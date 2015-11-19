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
        configureImageView(iconImage)
        configureLabel(info)
    }
    
    private func configureViewLayer() {
        self.layer.cornerRadius = 10.0
        self.layer.shadowRadius = 10.0
        self.layer.shadowOpacity = 0.8
        
        self.backgroundColor = UIColor.whiteColor()
    }
    
    private func configureImageView(image: UIImage) {
        let imageWidth = frame.width / 3
        let imageXPosition = frame.width / 2 - imageWidth / 2
        let imageYPosition = frame.height / 3 - imageWidth / 1.5
        
        iconView = UIImageView(image: image)
        iconView?.frame = CGRect(x: imageXPosition, y: imageYPosition, width: imageWidth, height: imageWidth)
        iconView?.contentMode = .ScaleAspectFill
        
        self.addSubview(iconView!)
    }
    
    private func configureLabel(text: String) {
        infoLabel = UILabel()
        infoLabel?.attributedText = NSAttributedString(string: text, attributes: [NSFontAttributeName: UIFont.systemFontOfSize(17, weight: UIFontWeightLight)])
        infoLabel?.frame = CGRect(x: 0, y: 0, width: frame.width - 60, height: 0)
        infoLabel?.numberOfLines = 0
        infoLabel!.sizeToFit()
        infoLabel?.clipsToBounds = true
        infoLabel!.center = CGPoint(x: frame.width / 2, y: frame.height / 1.5)
        
        self.addSubview(infoLabel!)
    }
}