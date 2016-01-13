//
//  CalendarHeaderView.swift
//  do
//
//  Created by Yusuke Hozumi on 1/8/16.
//  Copyright © 2016 Yusuke Hozumi. All rights reserved.
//

import UIKit

protocol CalendarHeaderViewDelegate: class {
    var cellSize: CGSize { get }
    var centerX: CGFloat { get }
}

class CalendarHeaderView: UICollectionReusableView {
    
    private let weekdays = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
    private var containerView = UIView()
    private var labelPosition: CGPoint = CGPoint(x: 0, y: 0)
    
    weak var delegate: CalendarHeaderViewDelegate?
    
    private func configureLabels() {
        for weekday in weekdays {
            let label = UILabel()
            label.attributedText = NSAttributedString(string: weekday, attributes: [NSFontAttributeName: UIFont.systemFontOfSize(14, weight: UIFontWeightLight)])
            
            guard let labelSize = delegate?.cellSize else { return }
            label.frame = CGRect(origin: labelPosition, size: labelSize)
            labelPosition.x += labelSize.width
            label.textAlignment = .Center
            label.textColor = UIColor(red: 177.0/255.0, green: 182.0/255.0, blue: 191.0/255.0, alpha: 1.0)
            containerView.addSubview(label)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        containerView = UIView(frame: self.frame)
        self.addSubview(containerView)
        configureLabels()
    }
}
