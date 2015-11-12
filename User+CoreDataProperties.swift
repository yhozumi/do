//
//  User+CoreDataProperties.swift
//  do
//
//  Created by Yusuke Hozumi on 11/1/15.
//  Copyright © 2015 Yusuke Hozumi. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension User {

    @NSManaged var name: String?
    @NSManaged var password: String?
    @NSManaged var emailAddress: String?
    @NSManaged var phoneNumber: String?
    @NSManaged var profilePicture: NSData?
    @NSManaged var tasks: NSSet?

}
