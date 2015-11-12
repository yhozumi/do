//
//  ProfileAvatarImage.swift
//  do
//
//  Created by Yusuke Hozumi on 10/29/15.
//  Copyright © 2015 Yusuke Hozumi. All rights reserved.
//

import UIKit

protocol ProfileAvatarImageDelegate: class {
    func openImagePickerController()
}

@IBDesignable
class ProfileAvatarImage: UIView {
    
    let profileImageView = UIImageView()
    
    weak var delegate: ProfileAvatarImageDelegate?
    
    var profileImage: UIImage? {
        didSet {
            for button in profileImageView.subviews {
                if let button = button as? UIButton {
                    button.removeFromSuperview()
                }
            }
        
            profileImageView.clipsToBounds = true
            profileImageView.image = profileImage
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var strokeColor: UIColor? {
        didSet {
            configure()
        }
    }
    
    @IBInspectable var strokeWidth: CGFloat? {
        didSet {
            configure()
        }
    }
    
    private func configure() {
        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
        profileImageView.layer.borderColor = UIColor.whiteColor().CGColor
        profileImageView.backgroundColor = UIColor(red: 144.0/255.0, green: 149.0/255.0, blue: 159.0/255.0, alpha: 0.7)
        profileImageView.layer.borderWidth = 1.0
    }
    
    private func setUp() {
        let width = UIScreen.mainScreen().bounds.width
        let diameter = width / 5
        let x = (CGRectGetWidth(UIScreen.mainScreen().bounds) - diameter) / 2
        profileImageView.frame = CGRect(x: x , y: 0, width: width / 5, height: width / 5)
        self.addSubview(profileImageView)
        
        let addButton = UIButton(type: .System)
        addButton.addTarget(self, action: "addImage:", forControlEvents: .TouchUpInside)
        addButton.setTitle("add", forState: .Normal)
        addButton.tintColor = UIColor.whiteColor()
        addButton.frame = CGRect(x: CGRectGetMidX(profileImageView.bounds) - 15, y: CGRectGetMidY(profileImageView.bounds) - 15, width: 30, height: 30)
        profileImageView.addSubview(addButton)
        profileImageView.userInteractionEnabled = true
        
    }
    
    func addImage(sender: UIButton) {
        delegate?.openImagePickerController()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

        setUp()
        configure()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
}
