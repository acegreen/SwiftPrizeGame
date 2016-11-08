//
//  Functions.swift
//  SwiftPrizeGame
//
//  Created by Ace Green on 11/7/16.
//  Copyright © 2016 Ace Green. All rights reserved.
//

import Foundation

class Functions {
    
    // Random number between low and high range
    class func randomInRange (low: Int, high: Int) -> Int {
        var randomNumber = Int(arc4random_uniform(UInt32(high)))
        randomNumber = max(randomNumber, low)
        randomNumber = min(randomNumber, high - low)
    
        return randomNumber
    }
}
