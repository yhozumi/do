//
//  MainViewNavigationController.swift
//  do
//
//  Created by Yusuke Hozumi on 12/9/15.
//  Copyright © 2015 Yusuke Hozumi. All rights reserved.
//

import UIKit

protocol MainViewNavigationControllerDelgate: class {
    func mainViewNavigationControllerDidPressMenu(controller: UINavigationController)
}

class MainViewNavigationController: UINavigationController {
    
    weak var mainViewNavigationControllerDelegate: MainViewNavigationControllerDelgate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addButtonAndTranslucentBar()
    }
    
    func menuButtonPressed(button: UIBarButtonItem) {
        mainViewNavigationControllerDelegate?.mainViewNavigationControllerDidPressMenu(self)
    }
    
    private func createMenubutton(image: UIImage.AssetIdentifier) -> UIBarButtonItem? {
        if navigationItem.leftBarButtonItem == nil {
            let button = UIButton(type: .Custom)
            button.frame = CGRect(x: 0, y: 0, width: 28, height: 20)
            button.addTarget(self, action: Selector("menuButtonPressed:"), forControlEvents: .TouchUpInside)
            
            let image = UIImageView(image: UIImage(assetIdentifier: image))
            image.frame = CGRect(x: 0, y: 0, width: 28, height: 20)
            button.addSubview(image)
            
            let menuButton = UIBarButtonItem(customView: button)
            return menuButton
        } else {
            return nil
        }
    }
    
    private func configureTranslucentNavigationBar() {
        self.topViewController?.navigationController!.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.topViewController?.navigationController!.navigationBar.translucent = true
        self.topViewController?.navigationController!.navigationBar.shadowImage = UIImage()
    }
    
    private func addButtonAndTranslucentBar() {
        configureTranslucentNavigationBar()
        self.topViewController?.navigationItem.leftBarButtonItem = createMenubutton(.Menu)
    }
}

extension MainViewNavigationController: UINavigationBarDelegate {
    override func setViewControllers(viewControllers: [UIViewController], animated: Bool) {
        super.setViewControllers(viewControllers, animated: animated)
        addButtonAndTranslucentBar()
    }
}
