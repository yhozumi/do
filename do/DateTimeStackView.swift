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
    
    override func removeFromSuperview() {
        super.removeFromSuperview()
        timer?.invalidate()
    }
    
    deinit {
        print("stack view deinitialized")
    }
    
    
}