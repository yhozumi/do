//
//  HomeScreenViewController.swift
//  do
//
//  Created by Yusuke Hozumi on 11/30/15.
//  Copyright © 2015 Yusuke Hozumi. All rights reserved.
//

import UIKit

class HomeScreenViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addButton: UIButton!
    
    private var originalTableViewContentOffsetY: CGFloat?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = UIColor.clearColor()
        originalTableViewContentOffsetY = tableView.contentOffset.y
        print(originalTableViewContentOffsetY)
    }
    
    @IBAction func addButtonPressed(sender: AnyObject) {
    }
}

extension HomeScreenViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("HomeCell")! as UITableViewCell
        cell.textLabel?.text = "test"
        cell.selectedBackgroundView = UIView()
        cell.textLabel?.textColor = UIColor.whiteColor()
        cell.backgroundColor = UIColor.clearColor()
        return cell
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        UIView.animateWithDuration(0.2, animations: {
            self.addButton.alpha = 0.0
            
            self.addButton.center.y += self.addButton.frame.height
        })
    }
    
    func scrollViewDidScrollToTop(scrollView: UIScrollView) {
        UIView.animateWithDuration(0.2, animations: {
            self.addButton.alpha = 1.0
            self.addButton.center.y -= self.addButton.frame.height
        })
    }
}

