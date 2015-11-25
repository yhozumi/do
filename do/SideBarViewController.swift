//
//  SideBarViewController.swift
//  do
//
//  Created by Yusuke Hozumi on 11/25/15.
//  Copyright © 2015 Yusuke Hozumi. All rights reserved.
//

import UIKit

class SideBarViewController: UIViewController {
    private var leftMenuBar: UIViewController!
    private var mainView: UIViewController!
    private var overlap: CGFloat!
    private var scrollView: UIScrollView!
    
    init(leftMenuBar: UIViewController, mainView: UIViewController, overlap: CGFloat) {
        self.leftMenuBar = leftMenuBar
        self.mainView = mainView
        self.overlap = overlap
        
        super.init(nibName: nil, bundle: nil)
        
        self.view.backgroundColor = UIColor.blackColor()
        
        configureScrollView()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func configureScrollView() {
        scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        let horizontalConstraint = NSLayoutConstraint.constraintsWithVisualFormat("H:|[scrollView]|", options: [], metrics: nil, views: ["scrollView": scrollView])
        let verticalConstraint = NSLayoutConstraint.constraintsWithVisualFormat("V:|[scrollView]|", options: [], metrics: nil, views: ["scrollView": scrollView])
        NSLayoutConstraint.activateConstraints(horizontalConstraint + verticalConstraint)
    }
    
    private func configureViewControllers() {
        addViewController(leftMenuBar)
        addViewController(mainView)
        
        let views = ["container": view, "left": leftMenuBar.view, "main": mainView.view]
        let horizontalConstraint = NSLayoutConstraint.constraintsWithVisualFormat("H:|[left][main(==container)]|", options: [.AlignAllTop, .AlignAllBottom], metrics: nil, views: views)
        let leftWidthConstraint = NSLayoutConstraint(item: leftMenuBar.view, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: 1.0, constant: -overlap)
        let verticalConstraint = NSLayoutConstraint.constraintsWithVisualFormat("V:|main(==container)|", options: [], metrics: nil, views: views)
        
        NSLayoutConstraint.activateConstraints(horizontalConstraint + verticalConstraint + [leftWidthConstraint])
        
    }
    
    private func addViewController(viewController: UIViewController) {
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(viewController.view)
        addChildViewController(viewController)
        viewController.didMoveToParentViewController(self)
    }
}
