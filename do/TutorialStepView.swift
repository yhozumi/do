//
//  TutorialStepView.swift
//  do
//
//  Created by Yusuke Hozumi on 11/10/15.
//  Copyright © 2015 Yusuke Hozumi. All rights reserved.
//

import UIKit

class TutorialStepView: UIView {
    private var iconView: UIImageView?
    private var infoLabel: UILabel?

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(frame: CGRect, iconImage: UIImage, info: String) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.whiteColor() 
        
        iconView = UIImageView(image: iconImage)
        infoLabel = UILabel()
        infoLabel!.text = info
        
    }
}
