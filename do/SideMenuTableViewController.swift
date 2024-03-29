//
//  SideMenuTableViewController.swift
//  do
//
//  Created by Yusuke Hozumi on 11/25/15.
//  Copyright © 2015 Yusuke Hozumi. All rights reserved.
//

import UIKit

protocol SideMenuTableViewControllerDelegate: class {
    func sideMenuTableViewController(controller: UITableViewController, didSelectTableCell tableCellName: SideMenuTableCellName)
}

enum SideMenuTableCellName: String {
    case Home = "Home"
    case Calendar = "Calendar"
    case Overview = "Overview"
    case Groups = "Groups"
    case Lists = "Lists"
    case Profile = "Profile"
    case Timeline = "Timeline"
    case Settings = "Settings"
    case Logout = "Logout"
}

class SideMenuTableViewController: UITableViewController {
    
    @IBOutlet weak var homeNoificationlabel: UILabel!
    @IBOutlet weak var calendarNotificationlabel: UILabel!
    @IBOutlet weak var overviewNotificationLabel: UILabel!
    @IBOutlet weak var groupsNotificationLabel: UILabel!
    @IBOutlet weak var listsNotificationLabel: UILabel!
    @IBOutlet weak var profileNotificationLabel: UILabel!
    @IBOutlet weak var timelineNotificationLabel: UILabel!
    
    weak var sideMenuTableViewDelegate: SideMenuTableViewControllerDelegate?
    
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
        
        var tableCellName: SideMenuTableCellName?
        
        switch indexPath.section {
        case 0: break //change code to change profile pics or direct to profile page.
        case 1:
            switch indexPath.row {
            case 0: break //Empty Static cell for spacing.
            case 1: tableCellName = SideMenuTableCellName.Home
            case 2: tableCellName = SideMenuTableCellName.Calendar
            case 3: tableCellName = SideMenuTableCellName.Overview
            case 4: tableCellName = SideMenuTableCellName.Groups
            case 5: tableCellName = SideMenuTableCellName.Lists
            case 6: tableCellName = SideMenuTableCellName.Profile
            case 7: tableCellName = SideMenuTableCellName.Timeline
            default: break
            }
        case 2:
            switch indexPath.row {
            case 0: tableCellName = SideMenuTableCellName.Settings
            case 1: tableCellName = SideMenuTableCellName.Logout
            default: break
            }
        default: break
        }
        
        if let tableCellName = tableCellName {
            sideMenuTableViewDelegate?.sideMenuTableViewController(self, didSelectTableCell: tableCellName)
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


