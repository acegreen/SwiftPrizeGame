//
//  Extensions.swift
//  SwiftPrizeGame
//
//  Created by Ace Green on 11/7/16.
//  Copyright © 2016 Ace Green. All rights reserved.
//

import Foundation

extension Array {
    func sample() -> Element {
        let index = Int(arc4random_uniform(UInt32(self.count)))
        return self[index]
    }
}
