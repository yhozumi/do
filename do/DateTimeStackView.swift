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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        dateLabel.text = dateFormatter.stringFromDate(date)
        dayLabel.text = dayFormatter.stringFromDate(date)
        clockView.layer.cornerRadius = clockView.frame.width / 2
    }
}