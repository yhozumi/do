//
//  TutorialScreenViewController.swift
//  do
//
//  Created by Yusuke Hozumi on 11/10/15.
//  Copyright © 2015 Yusuke Hozumi. All rights reserved.
//

import UIKit

class TutorialScreenViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let subViewWidth = self.view.frame.width * 0.80
        let subViewHeight = self.view.frame.height * 0.66
        let subViewFrame = CGRect(x: 0, y: 0, width: subViewWidth, height: subViewHeight)
        
        let firstView = TutorialStepView(frame: subViewFrame, iconImage: UIImage(), info: "test")
        
    }
    
}
