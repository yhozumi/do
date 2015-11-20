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
        configureViews()
    }
    
    private func configureViews() {
        let subViewWidth = self.view.frame.width * 0.80
        let subViewHeight = self.view.frame.height * 0.66
        let leadingMargin = (self.view.frame.width - subViewWidth) / 2
        let topMargin = (self.view.frame.height - subViewHeight) / 3
        let subViewFrame = CGRect(x: leadingMargin, y: topMargin, width: subViewWidth, height: subViewHeight)
        
        let firstView = TutorialStepView(frame: subViewFrame, iconImage: UIImage(assetIdentifier: .Pencil), info: "Write notes and keep track of events")
        firstView.frame.origin.y += 20
        firstView.alpha = 0.4
        
        let secondView = TutorialStepView(frame: subViewFrame, iconImage: UIImage(assetIdentifier: .Tasks), info: "Tasks keep track of people and events")
        secondView.frame.origin.y += 50
        secondView.alpha = 0.6
        
        let thirdView = TutorialStepView(frame: subViewFrame, iconImage: UIImage(assetIdentifier: .Wireless), info: "Wirelessly sync all events and content")
        thirdView.frame.origin.y += 80
        
        let tutorialViews = [firstView, secondView, thirdView]
        
        for view in tutorialViews {
            self.view.addSubview(view)
            let panGesture = UIPanGestureRecognizer(target: self, action: Selector("handlePan:"))
            view.addGestureRecognizer(panGesture)
        }
    }
    
    private func cleanUpSlideView(viewToCleanUp: UIView) {
        viewToCleanUp.removeFromSuperview()
        UIView.animateWithDuration(0.5, animations: {
            self.view.subviews.last?.alpha = 1.0
            self.view.subviews.last!.frame.origin.y += 30
            }, completion: { _ in
               
        })
    }
    
    //slide the view back into the center for when I implement UIPageControl
    private func slideViewIn(direction: SlideDirection, viewToSlide: UIView) {
        viewToSlide.alpha = 0.0
        self.view.addSubview(viewToSlide)
        switch direction {
        case .Left:
            UIView.animateWithDuration(0.5, animations: {
                viewToSlide.center.x += self.view.center.x
                viewToSlide.alpha = 1.0
            })
        case .Right:
            UIView.animateWithDuration(0.5, animations: {
                viewToSlide.center.x -= self.view.center.x
                viewToSlide.alpha = 1.0
            })
        }
    }
    
    private func slideViewOut(direction: SlideDirection, viewToSlide: UIView) {
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
        let slidingView = self.view.subviews.last!
        let threshold = slidingView.bounds.width / 4
        
        switch gesture.state {
        case .Began:
            initialLocation = slidingView.center
        case .Changed:
            slidingView.center.x = initialLocation.x + translation.x
        case .Ended:
            if self.view.subviews.last?.center.x < threshold {
                slideViewOut(.Left, viewToSlide: slidingView)
            } else if slidingView.center.x > self.view.bounds.width - threshold {
                slideViewOut(.Right, viewToSlide: slidingView)
            } else {
                UIView.animateWithDuration(0.4, animations: {
                    slidingView.center.x = self.initialLocation.x
                })
            }
        default:
            break
        }
    }
}
