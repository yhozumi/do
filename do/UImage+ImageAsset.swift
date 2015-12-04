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
        case Calendar = "calendar"
        case Email = "email"
        case Group = "group"
        case Home = "home"
        case Lists = "lists"
        case Logout = "logout"
        case Mark = "mark"
        case Menu = "menu"
        case Name = "name"
        case Overview = "overview"
        case Password = "password"
        case Pencil = "Pencil"
        case Phone = "phone"
        case Settings = "settings"
        case SignIn = "signInButton"
        case Tasks = "tasks"
        case Timeline = "timeline"
        case Wireless = "WirelessLogo"
    }
    
    convenience init(assetIdentifier: AssetIdentifier) {
        self.init(named: assetIdentifier.rawValue)!
    }
}