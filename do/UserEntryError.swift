//
//  UserEntryError.swift
//  do
//
//  Created by Yusuke Hozumi on 12/14/15.
//  Copyright © 2015 Yusuke Hozumi. All rights reserved.
//

import Foundation

enum UserEntryError: ErrorType {
    case PasswordTooShort
    case InvalidEntry
    case PasswordNotMatching
    case UserInvalid
    case InvalidEmail
    case PhoneNumberInvalid
    
    var description: String {
        switch self {
        case .PasswordTooShort:
            return "Password must be at least 8 characters long"
        case .InvalidEntry:
            return "Missing Field"
        case .PasswordNotMatching:
            return "Password does not match the user name"
        case .UserInvalid:
            return "User does not exist"
        case .InvalidEmail:
            return "Email format is not correct"
        case .PhoneNumberInvalid:
            return "Please enter a 10 digit phone number"
        }
    }
}
