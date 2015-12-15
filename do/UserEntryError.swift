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
}
