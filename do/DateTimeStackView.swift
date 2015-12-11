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
    
    private var timer: NSTimer?
    private var hours: String?
    private var minutes: String?
    
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
    
    private lazy var timeFormatter: NSDateFormatter = {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "HH : MM"
        return formatter
    }()
    
    func timerCalled() {
        date = NSDate()
        let timeTuple = createHoursAndMinutesFromDate(date)
        print("\(timeTuple.0):\(timeTuple.1)")
        //print(dateFormatter.stringFromDate(date))
    }
    
    private func updateLabels() {
        dateLabel.text = dateFormatter.stringFromDate(date)
        dayLabel.text = dayFormatter.stringFromDate(date)
    }
    
    private func createHoursAndMinutesFromDate(date: NSDate) -> (String, String) {
        let calendar = NSCalendar.currentCalendar()
        let time = calendar.components([.Hour, .Minute], fromDate: date)
        let hour = "\(time.hour)"
        let minutes = "\(time.minute)"
        return (hour, minutes)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        updateLabels()
        
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