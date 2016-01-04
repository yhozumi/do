//
//  UserEntryError.swift
//  do
//
//  Created by Yusuke Hozumi on 12/14/15.
//  Copyright © 2015 Yusuke Hozumi. All rights reserved.
//

import UIKit

enum UserEntryError: ErrorType {
    case PasswordTooShort
    case InvalidEntry
    case PasswordNotMatching
    case UserInvalid
    case InvalidEmail
    case InvalidPhoneNumber
    
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
        case .InvalidPhoneNumber:
            return "Please use a 10 digit US Phone Number"
        }
    }
    
    static func displayErrorMessageToUser(error: UserEntryError, errorMessageLabel: UILabel
        ) {
        errorMessageLabel.text = error.description
        UIView.animateWithDuration(0.5, animations: {
            errorMessageLabel.alpha = 1.0
            }, completion: {_ in
                UIView.animateWithDuration(0.5, delay: 5, options: [], animations: {
                    errorMessageLabel.alpha = 0.0
                    }, completion: nil)
        })
    }
}
