//
//  Block.swift
//  SwiftPrizeGame
//
//  Created by Ace Green on 11/7/16.
//  Copyright © 2016 Ace Green. All rights reserved.
//

import SpriteKit

let NumberOfColors: UInt32 = 4

enum BlockColor: Int, CustomStringConvertible {
    
    case blue = 0, orange, purple, red
    
    var spriteName: String {
        switch self {
        case .blue:
            return "blue"
        case .orange:
            return "orange"
        case .purple:
            return "purple"
        case .red:
            return "red"
        }
    }
    
    var description: String {
        return self.spriteName
    }
    
    static func random() -> BlockColor {
        return BlockColor(rawValue:Int(arc4random_uniform(NumberOfColors)))!
    }
}

class Block: Hashable, CustomStringConvertible {
    
    // Constants
    var color: BlockColor
    
    // Variables
    var column: Int
    var row: Int
    
    var sprite: SKSpriteNode?
    
    var spriteName: String {
        return color.description
    }
    
    var hashValue: Int {
        return self.column ^ self.row
    }
    
    var description: String {
        return "\(color) (\(column), \(row))"
    }
    
    init(column:Int, row:Int, color:BlockColor) {
        self.column = column
        self.row = row
        self.color = color
    }
}

func ==(lhs: Block, rhs: Block) -> Bool {
    return lhs.column == rhs.column && lhs.row == rhs.row && lhs.color.rawValue == rhs.color.rawValue
}
