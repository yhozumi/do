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
    case ZeroToFour
    case FiveToNine
    case TenToFourteen
    case FifteenToNinteen
    case TwentyToTwentyFour
    case TwentyFiveToTwentyNine
    case ThirtyToThirtyFour
    case ThirtyFiveToThirtyNine
    case FourtyToFourtyFour
    case FourtyFiveToFourtyNine
    case FiftyToFiftyFour
    case FiftyFiveToFiftyNine
    case Sixty
    
    var radians: CGFloat {
        switch self {
        case .ZeroToFour:
            return CGFloat(3 * M_PI / 2)
        case .FiveToNine:
            return CGFloat(5 * M_PI / 3)
        case .TenToFourteen:
            return CGFloat(11 * M_PI / 6)
        case .FifteenToNinteen:
            return CGFloat(2 * M_PI)
        case .TwentyToTwentyFour:
            return CGFloat(M_PI / 6)
        case .TwentyFiveToTwentyNine:
            return CGFloat(M_PI / 3)
        case .ThirtyToThirtyFour:
            return CGFloat(M_PI / 2)
        case .ThirtyFiveToThirtyNine:
            return CGFloat(2 * M_PI / 3)
        case .FourtyToFourtyFour:
            return CGFloat(5 * M_PI / 6)
        case .FourtyFiveToFourtyNine:
            return CGFloat(M_PI)
        case .FiftyToFiftyFour:
            return CGFloat(7 * M_PI / 6)
        case .FiftyFiveToFiftyNine:
            return CGFloat(4 * M_PI / 3)
        case .Sixty:
            return CGFloat(3 * M_PI / 2)
        }
    }
    
    static func configureRadiansWithMinutes(minutes: Int) -> CGFloat {
        switch minutes {
        case 0...4: return self.ZeroToFour.radians
        case 5...9: return self.FiveToNine.radians
        case 10...14: return self.TenToFourteen.radians
        case 15...19: return self.FifteenToNinteen.radians
        case 20...24: return self.TwentyToTwentyFour.radians
        case 25...29: return self.TwentyFiveToTwentyNine.radians
        case 30...34: return self.ThirtyToThirtyFour.radians
        case 35...39: return self.ThirtyFiveToThirtyNine.radians
        case 40...44: return self.FourtyToFourtyFour.radians
        case 45...49: return self.FourtyFiveToFourtyNine.radians
        case 50...54: return self.FiftyToFiftyFour.radians
        case 55...59: return self.FiftyFiveToFiftyNine.radians
        default: return self.Sixty.radians
        }
    }
}
