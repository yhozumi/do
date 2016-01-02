//
//  UserEntryValidator.swift
//  do
//
//  Created by Yusuke Hozumi on 12/26/15.
//  Copyright © 2015 Yusuke Hozumi. All rights reserved.
//

import Foundation

protocol UserEntryValidator {
    func isUserNameValid(userName: String) -> Bool
    func isPasswordValid(password: String) -> Bool
    func isUserExisiting(userName: String, password: String, users: [User]) -> Bool
    func isUserPasswordMatching(userName: String, password: String, users: [User]) -> Bool
    
}

extension UserEntryValidator {
    func isUserNameValid(userName: String) -> Bool {
        return userName.isEmpty || userName == "" ? false : true
    }
    
    func isPasswordValid(password: String)  -> Bool {
        return password.isEmpty || password == "" || password.characters.count < 8 ? false : true
    }
    
    func isUserExisiting(userName: String, password: String, users: [User]) -> Bool {
        let user = users.filter { $0.name == userName }.first
        return user == nil ? false : true
    }
    
    func isUserPasswordMatching(userName: String, password: String, users: [User]) -> Bool {
        let user = users.filter { $0.name == userName }.first
        guard let existingUser = user else { return false }
        return existingUser.password != password ? false : true
    }
}