//
//  UImage+ImageAsset.swift
//  do
//
//  Created by Yusuke Hozumi on 11/18/15.
//  Copyright © 2015 Yusuke Hozumi. All rights reserved.
//

import UIKit

extension UIImage {
    enum AssetIdentifier: String {
        case Connect = "connect"
        case Back = "back"
        case Background = "background"
        case Email = "email"
        case Mark = "mark"
        case Name = "name"
        case Password = "password"
        case Pencil = "Pencil"
        case Phone = "phone"
        case SignIn = "signInButton"
        case Tasks = "tasks"
        case Wireless = "WirelessLogo"
    }
    
    convenience init(assetIdentifier: AssetIdentifier) {
        self.init(named: assetIdentifier.rawValue)!
    }
}