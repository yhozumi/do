//
//  DateTimeStackView.swift
//  do
//
//  Created by Yusuke Hozumi on 12/10/15.
//  Copyright © 2015 Yusuke Hozumi. All rights reserved.
//

import UIKit

class DateTimeStackView: UIStackView {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var clockView: UIView!
    @IBOutlet weak var hourLabel: UILabel!
    
    private var minutesView: UIView!
    private var minutesLabel: UILabel!
    private var timer: NSTimer?
    private var timeTuple: (String, String)?
    
    private lazy var date: NSDate = {
        let today = NSDate()
        return today
    }()
    
    private lazy var dateFormatter: NSDateFormatter = {
        let formatter = NSDateFormatter()
        formatter.dateStyle = .LongStyle
        return formatter
    }()
    
    private lazy var dayFormatter: NSDateFormatter = {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "EEEE"
        return formatter
    }()
    
    //This method will layout and position the minutesView on the clockView.
    private func setUpMinutesView() {
        self.minutesView = UIView(frame: CGRect(x: 0, y: 0, width: clockView.bounds.width / 3, height: clockView.bounds.height / 3))
        self.minutesView.backgroundColor = UIColor.whiteColor()
        self.minutesView.layer.cornerRadius = self.minutesView.bounds.width / 2
        
        let endAngle = MinutesHandIdentifier.configureRadiansWithMinutes(Int(timeTuple!.1)!)
        
        let path = UIBezierPath(arcCenter: self.clockView.center, radius: clockView.bounds.width / 2, startAngle: CGFloat(0), endAngle: endAngle, clockwise: true)
        
        self.minutesView.center = path.currentPoint
        self.addSubview(minutesView)
        
        setUpMinutesLabel()
    }
    
    //helper method to instantiate minutesLabel
    private func setUpMinutesLabel() {
        minutesLabel = UILabel(frame: CGRect.zero)
        minutesLabel.textColor = UIColor.whiteLightGreyColor()
        minutesLabel.text = timeTuple!.1
        minutesLabel.sizeToFit()
        minutesLabel.center = minutesView.center
        self.addSubview(minutesLabel)
    }
    
    func timerCalled() {
        date = NSDate()
        timeTuple = createHoursAndMinutesFromDate(date)
        updateTimeLabels(timeTuple!)
    }
    
    //Helper method that's called everytime the timer is fired
    private func updateTimeLabels(time: (String, String)) {
        hourLabel.text = time.0
        guard let minutesLabel = minutesLabel else { return }
        minutesLabel.text = time.1
        minutesLabel.sizeToFit()
        
        if Int(time.1)! % 5 == 0 {
            let endAngle = MinutesHandIdentifier.configureRadiansWithMinutes(Int(time.1)!)
            let path = UIBezierPath(arcCenter: self.clockView.center, radius: self.clockView.bounds.width / 2, startAngle: CGFloat(0), endAngle: endAngle, clockwise: true)
            UIView.animateWithDuration(0.5, animations: {
                self.minutesView.center = path.currentPoint
                }, completion: nil)
        }
    }
    
    private func updateLabels() {
        dateLabel.text = dateFormatter.stringFromDate(date)
        dayLabel.text = dayFormatter.stringFromDate(date)
    }
    
    //Helper method to create time tuple to display hour and minutes to the user.
    private func createHoursAndMinutesFromDate(date: NSDate) -> (String, String) {
        let calendar = NSCalendar.currentCalendar()
        let time = calendar.components([.Hour, .Minute], fromDate: date)
        let hour = time.hour > 12 ? "\(time.hour - 12)" : "\(time.hour)"
        let minutes = "\(time.minute)"
        return (hour, minutes)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        updateLabels()
        timeTuple = createHoursAndMinutesFromDate(date)  
        if let timeTuple = timeTuple {
            updateTimeLabels(timeTuple)
        }
        clockView.layer.cornerRadius = clockView.frame.width / 2
        
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("timerCalled"), userInfo: nil, repeats: true)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setUpMinutesView()
    }
    
    override func removeFromSuperview() {
        super.removeFromSuperview()
        timer?.invalidate() //invalidates the timer so that timer doesn't keep this view in memory and cause memory leak
    }
    
    deinit {
        print("stack view deinitialized")
    }
    
    
}