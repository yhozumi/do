//
//  HomeScreenViewController.swift
//  do
//
//  Created by Yusuke Hozumi on 11/30/15.
//  Copyright © 2015 Yusuke Hozumi. All rights reserved.
//

import UIKit

protocol HomeScreenViewControllerDelegate: class {
    func homeScreenViewControllerDidPressMenuButton()
}

class HomeScreenViewController: UIViewController {
    weak var delegate: HomeScreenViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.leftBarButtonItem = createMenubutton(.Menu)
    }
    
    
    func menuButtonPressed(menuButton: UIBarButtonItem) {
        delegate?.homeScreenViewControllerDidPressMenuButton()
    }
    
    
    private func createMenubutton(image: UIImage.AssetIdentifier) -> UIBarButtonItem {
        let button = UIButton(type: .Custom)
        button.frame = CGRect(x: 0, y: 0, width: 28, height: 20)
        button.addTarget(self, action: Selector("menuButtonPressed:"), forControlEvents: .TouchUpInside)
        
        let image = UIImageView(image: UIImage(assetIdentifier: image))
        image.frame = CGRect(x: 0, y: 0, width: 28, height: 20)
        button.addSubview(image)
        
        let menuButton = UIBarButtonItem(customView: button)
        return menuButton
    }
}

