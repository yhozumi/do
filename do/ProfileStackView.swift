//
//  ProfileStackView.swift
//  do
//
//  Created by Yusuke Hozumi on 11/25/15.
//  Copyright © 2015 Yusuke Hozumi. All rights reserved.
//

import UIKit

class ProfileStackView: UIStackView {
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    private static let greyColor = UIColor(red: 144.0/255.0, green: 149.0/255.0, blue: 159.0/255.0, alpha: 0.9)
    
    private func configureImageView() {
        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
        profileImageView.backgroundColor = ProfileStackView.greyColor
        
    }
    
    //Need implementation for actually entering the data of the user that is logged in.
    private func configureLabels() {
        nameLabel.text = "Yusuke Hozumi"
        emailLabel.attributedText = NSAttributedString(string: "yusuke.hozumi@icloud.com", attributes: [NSForegroundColorAttributeName: ProfileStackView.greyColor])
    }
    
    override func drawRect(rect: CGRect) {
        configureImageView()
        configureLabels()
    }
}
