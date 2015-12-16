//
//  String+EmailValidation.swift
//  do
//
//  Created by Yusuke Hozumi on 12/16/15.
//  Copyright © 2015 Yusuke Hozumi. All rights reserved.
//

import Foundation

//Credit to Joel Garcia from StackOverflow
extension String {
    func isEmail() -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: [.CaseInsensitive])
             return regex.firstMatchInString(self, options: NSMatchingOptions(rawValue: 0), range: NSMakeRange(0, self.characters.count)) != nil
        } catch {
            return false
        }
    }
    
}