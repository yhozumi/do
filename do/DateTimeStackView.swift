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
    
    private func setUpMinutesView() {
        self.minutesView = UIView(frame: CGRect(x: 0, y: 0, width: clockView.bounds.width / 3, height: clockView.bounds.height / 3))
        self.minutesView.backgroundColor = UIColor.whiteColor()
        self.minutesView.layer.cornerRadius = self.minutesView.bounds.width / 2
        
        let path = UIBezierPath(arcCenter: self.clockView.center, radius: clockView.bounds.width / 2, startAngle: CGFloat(0), endAngle: CGFloat(3 * M_PI / 2), clockwise: true)
        
        self.minutesView.center = path.currentPoint
        self.addSubview(minutesView)
    }
    
    func timerCalled() {
        date = NSDate()
        timeTuple = createHoursAndMinutesFromDate(date)
        updateTimeLabels(timeTuple!)
    }
    
    private func updateTimeLabels(time: (String, String)) {
        hourLabel.text = time.0
    }
    
    private func updateLabels() {
        dateLabel.text = dateFormatter.stringFromDate(date)
        dayLabel.text = dayFormatter.stringFromDate(date)
    }
    
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
        timer?.invalidate()
    }
    
    deinit {
        print("stack view deinitialized")
    }
    
    
}