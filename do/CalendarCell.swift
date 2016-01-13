//
//  CalendarCell.swift
//  do
//
//  Created by Yusuke Hozumi on 1/3/16.
//  Copyright © 2016 Yusuke Hozumi. All rights reserved.
//

import UIKit

class CalendarCell: UICollectionViewCell {
    var dateLabel: UILabel!
    var dateText: String! {
        didSet {
            self.updateLabel()
        }
    }
    
    private func updateLabel() {
        if let dateLabel = dateLabel {
            dateLabel.text = dateText
        }
    }
    
    override func willMoveToSuperview(newSuperview: UIView?) {
        super.willMoveToSuperview(newSuperview)
        dateLabel = UILabel(frame: self.bounds)
        dateLabel.textAlignment = .Center
        dateLabel.textColor = UIColor.whiteColor()
        print("in awakeFromNib \(self.bounds)")
        addSubview(dateLabel)
        updateLabel()
    }
    
}
