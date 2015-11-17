//
//  TutorialScreenViewController.swift
//  do
//
//  Created by Yusuke Hozumi on 11/10/15.
//  Copyright © 2015 Yusuke Hozumi. All rights reserved.
//

import UIKit


class TutorialScreenViewController: UIViewController {
    
    enum SlideDirection {
        case Left
        case Right
    }
    
    private var initialLocation = CGPoint.zero
    
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
        secondView.frame.origin.y += 50
        secondView.alpha = 0.6
        
    
        let thirdView = TutorialStepView(frame: subViewFrame, iconImage: UIImage(), info: "test2")
        thirdView.frame.origin.y += 80
        
        let views = [firstView, secondView, thirdView]
        
        for view in views {
            self.view.addSubview(view)
            let panGesture = UIPanGestureRecognizer(target: self, action: Selector("handlePan:"))
            view.addGestureRecognizer(panGesture)
            view.layer.cornerRadius = 10.0
            view.layer.shadowRadius = 10.0
            view.layer.shadowOpacity = 0.8
        }
    }
    
    private func cleanUpSlideView(viewToCleanUp: UIView) {
        viewToCleanUp.removeFromSuperview()
        UIView.animateWithDuration(0.5, animations: {
            self.view.subviews.last?.alpha = 1.0
            self.view.subviews.last!.frame.origin.y += 30
            }, completion: nil)
    }
    
    private func slideView(direction: SlideDirection, viewToSlide: UIView) {
        switch direction {
        case .Left:
            UIView.animateWithDuration(0.5, animations: {
                viewToSlide.center.x -= self.view.bounds.width / 2
                }, completion: { _ in
                    self.cleanUpSlideView(viewToSlide)
            })
            
        case .Right:
            UIView.animateWithDuration(0.5, animations: {
                viewToSlide.center.x += self.view.bounds.width / 2
                }, completion: { _ in
                    self.cleanUpSlideView(viewToSlide)
            })
        }
    }
    
    func handlePan(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translationInView(self.view)
        
        switch gesture.state {
        case .Began:
            initialLocation = self.view.subviews.last!.center
        case .Changed:
            self.view.subviews.last?.center.x = initialLocation.x + translation.x
        case .Ended:
            if self.view.subviews.last?.center.x < 0 {
                slideView(.Left, viewToSlide: self.view.subviews.last!)
            } else if self.view.subviews.last?.center.x > self.view.bounds.width {
                slideView(.Right, viewToSlide: self.view.subviews.last!)
            } else {
                UIView.animateWithDuration(0.4, animations: {
                    self.view.subviews.last?.center.x = self.initialLocation.x
                })
            }
        default:
            break
        }
    }
    
}
