//
//  AppDelegate.swift
//  do
//
//  Created by Yusuke Hozumi on 10/28/15.
//  Copyright © 2015 Yusuke Hozumi. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var sidebarVC: SideBarViewController!
    
    private var isUserLoggedIn: Bool = true
    private lazy var coreDataStack = CoreDataStack()
    
    let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
    var mainNavVC = UINavigationController()
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        configureNavigationBar()
        if isUserLoggedIn {
            setUpSideBarViewController()
        } else {
            let rootNavVC = window?.rootViewController as! UINavigationController
            let rootVC = rootNavVC.viewControllers.first as! LoginViewController
            rootVC.coreDataStack = self.coreDataStack
        }
        
        return true
    }
    
    private func setUpSideBarViewController() {
        let menuVC = storyboard.instantiateViewControllerWithIdentifier("SideMenuTableViewController") as! SideMenuTableViewController
        mainNavVC = storyboard.instantiateViewControllerWithIdentifier("MainNavigationVC") as! MainViewNavigationController
        
        let overlap = UIScreen.mainScreen().bounds.width / 5
        
        menuVC.sideMenuTableViewDelegate = self
        
        sidebarVC = SideBarViewController(leftViewController: menuVC, mainViewController: mainNavVC, overlap: overlap)
        
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.backgroundColor = UIColor.whiteColor()
        window?.rootViewController = sidebarVC
        window?.makeKeyAndVisible()
    }
    
    
    // MARK: - Configurations
    private func configureNavigationBar() {
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor(), NSFontAttributeName: UIFont.systemFontOfSize(18, weight: UIFontWeightLight)]
    }
    
    private func instantiateAndAddViewControllerToMainView(tableCellName: SideMenuTableCellName) {
        let toAddViewController = self.storyboard.instantiateViewControllerWithIdentifier(tableCellName.rawValue)
        if mainNavVC.topViewController != toAddViewController {
            UIView.animateWithDuration(0.3, animations: {
                self.mainNavVC.topViewController!.view.alpha = 0.0
                }, completion: { _ in
                    self.mainNavVC.setViewControllers([toAddViewController], animated: true)
                    self.sidebarVC.collapseMenubar()
            })
        }
    }


    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        coreDataStack.saveContext()
    }
}


extension AppDelegate: SideMenuTableViewControllerDelegate {
    func sideMenuTableViewController(controller: UITableViewController, didSelectTableCell tableCellName: SideMenuTableCellName) {
        instantiateAndAddViewControllerToMainView(tableCellName)
    }
}




