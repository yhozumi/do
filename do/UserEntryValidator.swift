//
//  UserEntryValidator.swift
//  do
//
//  Created by Yusuke Hozumi on 12/26/15.
//  Copyright © 2015 Yusuke Hozumi. All rights reserved.
//

import Foundation

protocol UserEntryValidator {
    func checkLoginStatus(userName: String, password: String, users: [User]) throws -> Bool
    func checkSignUpStatus(userName: String, password: String, email: String, phoneNumber: String, users: [User]) throws -> Bool
}

extension UserEntryValidator {
    private func isUserNameValid(userName: String) -> Bool {
        return userName.isEmpty || userName == "" ? false : true
    }
    
    private func isPasswordValid(password: String)  -> Bool {
        return password.isEmpty || password == "" || password.characters.count < 8 ? false : true
    }
    
    private func isUserExisiting(userName: String, password: String, users: [User]) -> Bool {
        let user = users.filter { $0.name == userName }.first
        return user == nil ? false : true
    }
    
    private func isUserPasswordMatching(userName: String, password: String, users: [User]) -> Bool {
        let user = users.filter { $0.name == userName }.first
        guard let existingUser = user else { return false }
        return existingUser.password != password ? false : true
    }
    
    //Needs more error checking
    private func isPhoneNumberValid(phoneNumber: String) -> Bool {
        return phoneNumber.characters.count == 10 ? true : false
    }
    
    func checkLoginStatus(userName: String, password: String, users: [User]) throws -> Bool {
        guard isUserNameValid(userName) else { throw UserEntryError.InvalidEntry }
        guard isPasswordValid(password) else { throw UserEntryError.PasswordTooShort }
        guard isUserExisiting(userName, password: password, users: users) else { throw UserEntryError.UserInvalid }
        guard isUserPasswordMatching(userName, password: password, users: users) else { throw UserEntryError.PasswordNotMatching }
        return true
    }
    
    func checkSignUpStatus(userName: String, password: String, email: String, phonenNumber: String, users: [User]) throws -> Bool {
        guard isUserNameValid(userName) else { throw UserEntryError.InvalidEntry }
        guard isPasswordValid(password) else { throw UserEntryError.PasswordTooShort }
        guard email.isEmail() else { throw UserEntryError.InvalidEmail }
        guard isPhoneNumberValid(phonenNumber) else { throw UserEntryError.PhoneNumberInvalid }
        return true
    }
}