//
//  SideBarViewController.swift
//  do
//
//  Created by Yusuke Hozumi on 11/25/15.
//  Copyright © 2015 Yusuke Hozumi. All rights reserved.
//
import UIKit

class SideBarViewController: UIViewController {
    private var leftViewController: UITableViewController!
    private var mainViewController: UIViewController!
    private var overlap: CGFloat!
    private var scrollView: UIScrollView!
    
    private var isMenuOpened: Bool?
    
    required init(coder aDecoder: NSCoder) {
        assert(false, "Use init(leftViewController:mainViewController:overlap:)")
        super.init(coder: aDecoder)!
    }
    
    init(leftViewController: UITableViewController, mainViewController: UIViewController, overlap: CGFloat) {
        self.leftViewController = leftViewController
        self.mainViewController = mainViewController
        self.overlap = overlap
        
        super.init(nibName: nil, bundle: nil)
        
        self.view.backgroundColor = UIColor.blackColor()
        
        setupScrollView()
        setupViewControllers()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.scrollView.contentOffset.x = leftViewController.view.frame.width
        isMenuOpened = false
    }
    
    private func setupScrollView() {
        scrollView = UIScrollView()
        scrollView.pagingEnabled = true
        scrollView.bounces = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        view.addSubview(scrollView)
        
        let horizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|[scrollView]|", options: [], metrics: nil, views: ["scrollView": scrollView])
        let verticalConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|[scrollView]|", options: [], metrics: nil, views: ["scrollView": scrollView])
        NSLayoutConstraint.activateConstraints(horizontalConstraints + verticalConstraints)
        
        guard let mainViewController = mainViewController as? UINavigationController else { return }
        if let homeScreenVC = mainViewController.viewControllers[0] as? HomeScreenViewController {
            homeScreenVC.delegate = self
        }
    }
    
    private func setupViewControllers() {
        addViewController(leftViewController)
        addViewController(mainViewController)
        
        let views = ["left": leftViewController.view, "main": mainViewController.view, "outer": view]
        let horizontalConstraints = NSLayoutConstraint.constraintsWithVisualFormat(
            "|[left][main(==outer)]|", options: [.AlignAllTop, .AlignAllBottom], metrics: nil, views: views)
        let leftWidthConstraint = NSLayoutConstraint(
            item: leftViewController.view,
            attribute: .Width,
            relatedBy: .Equal,
            toItem: view,
            attribute: .Width,
            multiplier: 1.0, constant: -overlap)
        let verticalConstraints = NSLayoutConstraint.constraintsWithVisualFormat(
            "V:|[main(==outer)]|", options: [], metrics: nil, views: views)
        NSLayoutConstraint.activateConstraints(horizontalConstraints + verticalConstraints + [leftWidthConstraint])
        
    }
    
    private func addViewController(viewController: UIViewController) {
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(viewController.view)
        addChildViewController(viewController)
        viewController.didMoveToParentViewController(self)
    }
}

extension SideBarViewController: HomeScreenViewControllerDelegate {
    func homeScreenViewControllerDidPressMenuButton() {
        if isMenuOpened! {
            UIView.animateWithDuration(0.3, delay: 0.0, options: .CurveEaseInOut, animations: {
                self.scrollView.contentOffset.x = self.leftViewController.view.frame.width
                }, completion: { _ in
                    self.isMenuOpened! = false
            })
        } else {
            UIView.animateWithDuration(0.3, delay: 0.0, options: .CurveEaseIn, animations: {
                self.scrollView.contentOffset.x = 0.0
                }, completion: { _ in
                    self.isMenuOpened! = true
            })
        }
    }
}

extension SideBarViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(scrollView: UIScrollView) {
        isMenuOpened? = scrollView.contentOffset.x == 0.0
    }
}



