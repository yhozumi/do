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
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
        dateLabel = UILabel(frame: self.frame)
        dateLabel.textAlignment = .Center
        dateLabel.textColor = UIColor.whiteColor()
        addSubview(dateLabel)
    }
    
    private func updateLabel() {
        dateLabel.text = dateText
    }
}
