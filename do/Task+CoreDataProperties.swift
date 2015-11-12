//
//  Task+CoreDataProperties.swift
//  do
//
//  Created by Yusuke Hozumi on 10/29/15.
//  Copyright © 2015 Yusuke Hozumi. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Task {

    @NSManaged var date: NSDate?
    @NSManaged var time: NSDate?
    @NSManaged var user: User?

}
