//
//  SideMenuTableViewController.swift
//  do
//
//  Created by Yusuke Hozumi on 11/25/15.
//  Copyright © 2015 Yusuke Hozumi. All rights reserved.
//

import UIKit

class SideMenuTableViewController: UITableViewController {

    @IBOutlet weak var homeNoificationlabel: UILabel!
    @IBOutlet weak var calendarNotificationlabel: UILabel!
    @IBOutlet weak var overviewNotificationLabel: UILabel!
    @IBOutlet weak var groupsNotificationLabel: UILabel!
    @IBOutlet weak var listsNotificationLabel: UILabel!
    @IBOutlet weak var profileNotificationLabel: UILabel!
    @IBOutlet weak var timelineNotificationLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let labels: [UILabel] = [
            homeNoificationlabel,
            calendarNotificationlabel,
            overviewNotificationLabel,
            groupsNotificationLabel,
            listsNotificationLabel,
            profileNotificationLabel,
            timelineNotificationLabel
        ]
        
        setAlphaOnNotificationLabels(labels)
        
        configureTableView()
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.section {
        case 0:
            break //Do nothing for now. Change the code later to change the profile picture
        case 1:
            switch indexPath.row {
            case 0: //Home
            case 1: //Calendar
            case 2: //Overview
            case 3: //Groups
            case 4: //Lists
            case 5: //Profile
            case 6: //timeLine
            }
        case 2:
            switch indexPath.row {
            case 0:
            case 1:
            }
        
        }
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
    
    private func setAlphaOnNotificationLabels(labels: [UILabel]) {
        let _ = labels.map{ $0.alpha = 0.0 }
    }
}


