//
//  gradientSeparatorView.swift
//  do
//
//  Created by Yusuke Hozumi on 11/25/15.
//  Copyright © 2015 Yusuke Hozumi. All rights reserved.
//

import UIKit

class gradientSeparatorView: UIView {
    
    private var gradient = CAGradientLayer()
    
    private func configureGradientLayer() {
        gradient.startPoint = CGPoint(x: 0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1, y: 0.5)
        gradient.colors = [UIColor.whiteColor().CGColor, UIColor(red: 144.0/255.0, green: 149.0/255.0, blue: 159.0/255.0, alpha: 0.7).CGColor, UIColor.whiteColor().CGColor]
        gradient.locations = [0, 0.80, 1]
        gradient.frame = self.frame
    }
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureGradientLayer()
        self.layer.addSublayer(gradient)
    }
}
