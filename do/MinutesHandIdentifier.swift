//
//  MinutesHandIdentifier.swift
//  do
//
//  Created by Yusuke Hozumi on 12/18/15.
//  Copyright © 2015 Yusuke Hozumi. All rights reserved.
//

import Foundation
import UIKit

enum MinutesHandIdentifier {
    case ZeroToFive
    case SixToTen
    case ElevenToFifteen
    case SixteenToTwenty
    case TwentyOneToTwentyFive
    case TwentySixToThirty
    case ThirtyOneToThirtyFive
    case ThirtySixToFourty
    case FourtyOneToFourtyFive
    case FourtySixToFifty
    case FiftyOneToFiftyFive
    case FiftySixToSixty
    
    var radians: CGFloat {
        switch self {
        case .ZeroToFive:
            return CGFloat(4 * M_PI / 3)
        case .SixToTen:
            return CGFloat(7 * M_PI / 6)
        case .ElevenToFifteen:
            return CGFloat(2 * M_PI)
        case .SixteenToTwenty:
            return CGFloat(2 * M_PI / 3)
        case .TwentyOneToTwentyFive:
            return CGFloat(5 * M_PI / 6)
        case .TwentySixToThirty:
            return CGFloat(M_PI / 2)
        case .ThirtyOneToThirtyFive:
            return CGFloat(M_PI / 3)
        case .ThirtySixToFourty:
            return CGFloat(M_PI / 6)
        case .FourtyOneToFourtyFive:
            return CGFloat(M_PI)
        case .FourtySixToFifty:
            return CGFloat(11 * M_PI / 6)
        case .FiftyOneToFiftyFive:
            return CGFloat(5 * M_PI / 3)
        case .FiftySixToSixty:
            return CGFloat(3 * M_PI / 2)
        }
    }
}
