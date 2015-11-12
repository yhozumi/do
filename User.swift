//
//  User.swift
//  do
//
//  Created by Yusuke Hozumi on 11/1/15.
//  Copyright © 2015 Yusuke Hozumi. All rights reserved.
//

import UIKit
import CoreData


class User: NSManagedObject {
    
    var profileImage: UIImage? {
        if let profilePicture = profilePicture {
            return UIImage(data: profilePicture)
        } else {
            return nil
        }
    }
    
    
}
