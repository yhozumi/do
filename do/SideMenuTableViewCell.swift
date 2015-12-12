//
//  SideMenuTableViewCell.swift
//  do
//
//  Created by Yusuke Hozumi on 11/28/15.
//  Copyright © 2015 Yusuke Hozumi. All rights reserved.
//

import UIKit

class SideMenuTableViewCell: UITableViewCell {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.selectedBackgroundView = UIView()
    }
}
