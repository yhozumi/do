//
//  SideMenuTableViewCell.swift
//  do
//
//  Created by Yusuke Hozumi on 11/28/15.
//  Copyright © 2015 Yusuke Hozumi. All rights reserved.
//

import UIKit

class SideMenuTableViewCell: UITableViewCell {
    
    private var selectionLabel: UILabel?
    private var selectionImage: UIImageView?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setSelectionLabel()
        self.selectedBackgroundView = UIView()
    }
    
    override func setHighlighted(highlighted: Bool, animated: Bool) {
        if let selectionLabel = selectionLabel {
            selectionLabel.textColor = highlighted ? UIColor(red: 255.0/255.0, green: 51.0/255.0, blue: 102.0/255.0, alpha: 1.0) : UIColor.blackColor()
        }
        
        if let selectionImage = selectionImage {
            if highlighted {
                selectionImage.tintColor = UIColor(red: 255.0/255.0, green: 51.0/255.0, blue: 102.0/255.0, alpha: 1.0)
            }
        }
    }
    
    private func setSelectionLabel() {
        let labels = self.subviews.filter{ $0.isKindOfClass(UILabel) }
        if let labels = labels as? [UILabel] {
            selectionLabel = labels.first
        }
    }
    
    private func setSelectionImage() {
        let images = self.subviews.filter { $0.isKindOfClass(UIImageView) }
        if let images = images as? [UIImageView] {
            selectionImage = images.first
        }
    }
    
}
