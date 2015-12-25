//
//  HomeScreenViewController.swift
//  do
//
//  Created by Yusuke Hozumi on 11/30/15.
//  Copyright © 2015 Yusuke Hozumi. All rights reserved.
//

import UIKit
import CoreLocation

class HomeScreenViewController: UIViewController {
    
    enum ButtonSlideDirection {
        case Up
        case Down
    }
    
    @IBOutlet weak var weatherButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addButton: UIButton!
    
    private var originalButtonPosition: CGPoint?
    private var locationManager: CLLocationManager?
    private var geocoder: CLGeocoder?
    
    private var weatherJSONData: NSData? {
        didSet {
            guard let weatherJSONData = weatherJSONData else { return }
            parseWeatherJSON(weatherJSONData)
        }
    }
    
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
        configureTableViewAppearance()
        checkCoreLocationAuthorization()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        originalButtonPosition = addButton.center
    }
    
    private func checkCoreLocationAuthorization() {
        self.locationManager = CLLocationManager()
        
        switch CLLocationManager.authorizationStatus() {
        case .AuthorizedAlways, .AuthorizedWhenInUse:
            locationManager?.delegate = self
            locationManager?.desiredAccuracy = kCLLocationAccuracyHundredMeters
            locationManager?.startUpdatingLocation()
        case .NotDetermined:
            locationManager?.requestWhenInUseAuthorization()
        case .Denied:
            displayLocationServiceError()
        default: break
        }
    }
    
    private func displayLocationServiceError() {
        let alert = UIAlertController(title: "Location Service Error", message: "Please enable location Service to get the weather data", preferredStyle: .Alert)
        let action = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alert.addAction(action)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    private func configureTableViewAppearance() {
        weatherButton.setTitleTextAttributes([NSFontAttributeName: UIFont.systemFontOfSize(20, weight: UIFontWeightLight)], forState: .Normal)
        tableView.bounces = false
        tableView.backgroundColor = UIColor.clearColor()
        tableView.separatorStyle = .None
    }
    
    private func convertKelvinToDegree(kelvin: Double) -> Int {
        return Int(kelvin * (9/5) - 459.67)
    }
    
    @IBAction func addButtonPressed(sender: AnyObject) {
        print("Button pressed")
    }
    
    private func fetchWeatherData(url: NSURL) {
        let session = NSURLSession.sharedSession()
        let dataTask = session.dataTaskWithURL(url) {
            (data, response, error) in
            if let error = error {
                print("network error \(error)")
            } else {
                self.weatherJSONData = data
            }
        }
        dataTask.resume()
    }
    
    private func parseWeatherJSON(data: NSData) {
        do {
            guard let json = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments) as? [String: AnyObject] else { return }
            guard let jsonMain = json["main"] as? [String: NSObject] else { return }
            guard let temp = jsonMain["temp"] as? Double else { return }
            
            dispatch_async(dispatch_get_main_queue(), {
                self.weatherButton.title = "\(self.convertKelvinToDegree(temp))\u{00B0}"
            })
        } catch {
            print("Parsing error \(error)")
        }
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

extension HomeScreenViewController: CLLocationManagerDelegate {
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if locations.last?.horizontalAccuracy <= manager.desiredAccuracy {
            self.geocoder = CLGeocoder()
            geocoder?.reverseGeocodeLocation(locations.last!, completionHandler: { (placemarks, error) in
                if placemarks?.count > 0 {
                    let placemark = placemarks?.last
                    let url = self.getLocationWeatherWithPlacemark(placemark!)
                    self.fetchWeatherData(url)
                }
            })
            manager.stopUpdatingLocation()
        }
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        let alert = UIAlertController(title: "Location Error", message: "Couldn't find your location. Make sure your cellular or wifi is on and try again.", preferredStyle: .Alert)
        let action = UIAlertAction(title: "Ok", style: .Default, handler: nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
        weatherButton.title = "--"
    }
    
    private func getLocationWeatherWithPlacemark(placemark: CLPlacemark) -> NSURL {
        let zipCode = placemark.postalCode!
        let weatherURL = "http://api.openweathermap.org/data/2.5/weather?zip=\(zipCode),us&appid=2de143494c0b295cca9337e1e96b00e0"
        return NSURL(string: weatherURL)!
    }
}

