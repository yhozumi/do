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
        
        configureViewLayer()
        
        iconView = UIImageView(image: iconImage)
        iconView?.frame = CGRect(x: 0, y: 0, width: frame.width / 3, height: frame.width / 3)
        infoLabel = UILabel()
        infoLabel!.text = info
        
    }
    
    
    private func configureViewLayer() {
        self.layer.cornerRadius = 10.0
        self.layer.shadowRadius = 10.0
        self.layer.shadowOpacity = 0.8
        
        self.backgroundColor = UIColor.whiteColor()
    }
    
}
