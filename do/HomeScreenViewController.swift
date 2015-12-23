//
//  HomeScreenViewController.swift
//  do
//
//  Created by Yusuke Hozumi on 11/30/15.
//  Copyright © 2015 Yusuke Hozumi. All rights reserved.
//

import UIKit

class HomeScreenViewController: UIViewController {
    
    enum ButtonSlideDirection {
        case Up
        case Down
    }
    
    @IBOutlet weak var weatherButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addButton: UIButton!
    
    private var originalButtonPosition: CGPoint?
    
    private var weatherJSON = "http://api.openweathermap.org/data/2.5/weather?zip=43230,us&appid=2de143494c0b295cca9337e1e96b00e0"
    
    private let testArray = [
        "Band Practice",
        "Doctors Appointment",
        "Development Meeting",
        "Interview",
        "Soccer Practice",
        "STO",
        "Developer Conference",
        "Wedding",
        "New Years Party",
        "Work"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.bounces = false
        tableView.backgroundColor = UIColor.clearColor()
        tableView.separatorStyle = .None
        
        let jsonData = NSData(contentsOfURL: NSURL(string: weatherJSON)!)
        do {
            let json = try NSJSONSerialization.JSONObjectWithData(jsonData!, options: .AllowFragments)
            if let jsonMain = json["main"] as? [String: NSObject] {
                if let temp = jsonMain["temp"] as? Double {
                    weatherButton.title = "\(convertKelvinToDegree(temp))\u{00B0}"
                }
            }
        } catch {
            print("JSON Serialization error")
        }
    }
    
    private func convertKelvinToDegree(kelvin: Double) -> Int {
        return Int(kelvin * (9/5) - 459.67)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        originalButtonPosition = addButton.center
    }
    
    @IBAction func addButtonPressed(sender: AnyObject) {
        print("Button pressed")
    }
}

extension HomeScreenViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("HomeCell")! as UITableViewCell
        cell.textLabel?.text = testArray[indexPath.row]
        cell.selectedBackgroundView = UIView()
        cell.textLabel?.textColor = UIColor.whiteColor()
        cell.backgroundColor = UIColor.clearColor()
        return cell
    }
    
    private func slideButtonAndOpaque(slideDirection: ButtonSlideDirection, button: UIButton, scrollView: UIScrollView, buttonHeight: CGFloat) {
        switch slideDirection {
        case .Down:
            UIView.animateWithDuration(0.2, animations: {
                self.addButton.alpha = 0.0
                self.addButton.center.y += buttonHeight
                }, completion: { _ in
                    self.addButton.center = self.originalButtonPosition!
            })
        case .Up:
            dispatch_async(dispatch_get_main_queue()) {
                self.addButton.center.y += buttonHeight
            }
            UIView.animateWithDuration(0.2, animations: {
                self.addButton.center.y -= buttonHeight
                self.addButton.alpha = 1.0
                }, completion: { _ in
                    self.addButton.center = self.originalButtonPosition!
            })
        }
    }

    func scrollViewDidScroll(scrollView: UIScrollView) {
        if scrollView.contentOffset.y == 0.0 {
            slideButtonAndOpaque(.Up, button: addButton, scrollView: scrollView, buttonHeight: addButton.frame.height)
        } else if scrollView.contentOffset.y > 20.0 {
            slideButtonAndOpaque(.Down, button: addButton, scrollView: scrollView, buttonHeight: addButton.frame.height)
        }
    }
}

