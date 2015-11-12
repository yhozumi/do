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
        let leadingMargin = (self.view.frame.width - subViewWidth) / 2
        let topMargin = (self.view.frame.height - subViewHeight) / 3
        let subViewFrame = CGRect(x: leadingMargin, y: topMargin, width: subViewWidth, height: subViewHeight)
        
        
        let firstView = TutorialStepView(frame: subViewFrame, iconImage: UIImage(), info: "test")
        firstView.frame.origin.y += 20
        firstView.alpha = 0.4
        
        let secondView = TutorialStepView(frame: subViewFrame, iconImage: UIImage(), info: "test1")
        secondView.frame.origin.y += 40
        secondView.alpha = 0.6
        
    
        let thirdView = TutorialStepView(frame: subViewFrame, iconImage: UIImage(), info: "test2")
        thirdView.frame.origin.y += 60
        
        var views = [firstView, secondView, thirdView]
        
        for view in views {
            self.view.addSubview(view)
            let gesture = UISwipeGestureRecognizer(target: self, action: Selector("handleSwipe:"))
            gesture.direction = .Left
            let gestureRight = UISwipeGestureRecognizer(target: self, action: Selector("handleSwipe:"))
            gestureRight.direction = .Right
            view.addGestureRecognizer(gesture)
            view.addGestureRecognizer(gestureRight)
            view.layer.cornerRadius = 10.0
            view.layer.shadowRadius = 10.0
            view.layer.shadowOpacity = 0.8
        }
    }
    
    func handleSwipe(gesture: UISwipeGestureRecognizer) {
        if gesture.direction == .Left {
            UIView.animateWithDuration(0.5, animations: {
                self.view.subviews.last?.frame.origin.x -= self.view.bounds.width
                }, completion: {
                    _ in
                    let viewIndex = self.view.subviews.indexOf(self.view.subviews.last!)
                    let removedView = self.view.subviews[viewIndex!]
                    removedView.removeFromSuperview()
                    UIView.animateWithDuration(0.5, animations: {
                        self.view.subviews.last?.alpha = 1.0
                        self.view.subviews.last?.frame.origin.y += 20
                    })
                    
            })
        } else {
            UIView.animateWithDuration(0.5, animations: {
                self.view.subviews.last?.frame.origin.x += self.view.bounds.width
                }, completion: {
                    _ in
                    let viewIndex = self.view.subviews.indexOf(self.view.subviews.last!)
                    let removedView = self.view.subviews[viewIndex!]
                    removedView.removeFromSuperview()
                    UIView.animateWithDuration(0.5, animations: {
                        self.view.subviews.last?.alpha = 1.0
                        self.view.subviews.last?.frame.origin.y += 20
                    })
                    
            })
        }
    }
    
}
