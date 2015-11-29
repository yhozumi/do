//
//  SideMenuTableViewController.swift
//  do
//
//  Created by Yusuke Hozumi on 11/25/15.
//  Copyright © 2015 Yusuke Hozumi. All rights reserved.
//

import UIKit

class SideMenuTableViewController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
    }
    
    private func configureTableView() {
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.separatorStyle = .None
        self.tableView.contentInset = UIEdgeInsets(top: 22, left: 0, bottom: 0, right: 0)
        self.tableView.scrollEnabled = false
        
        print(UIScreen.mainScreen().bounds.height)
        
        if UIScreen.mainScreen().bounds.height < 650 {
            self.tableView.scrollEnabled = true
        }
    }
    
}
