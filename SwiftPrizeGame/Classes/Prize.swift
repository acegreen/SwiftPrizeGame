//
//  Prize.swift
//  SwiftPrizeGame
//
//  Created by Ace Green on 11/7/16.
//  Copyright © 2016 Ace Green. All rights reserved.
//

import SpriteKit

class Prize {
    
    // prize sprite node
    var sprite: SKSpriteNode?
    
    // The column and row representing the prize current place
    var column, row: Int
    
    // The players score
    var score = 0
    
    var spriteName = "prize"
    
    // Printable
    var description: String {
        return "prize current location: \(column), \(row)"
    }
    
    init(column: Int, row: Int) {
        self.column = column
        self.row = row
    }
    
    final class func random() -> (Int, Int) {
        
        let randomCol = Functions.randomInRange(low: 1, high: Constants.numColumns - 1)
        let randomRow = Functions.randomInRange(low: 1, high: Constants.numRows - 1)
        
        return (randomCol, randomRow)
    }
}
