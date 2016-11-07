//
//  Player.swift
//  SwiftPrizeGame
//
//  Created by Ace Green on 11/7/16.
//  Copyright © 2016 Ace Green. All rights reserved.
//

import SpriteKit

let cornerIndexes = [0, 4]

class Player: Hashable, CustomStringConvertible {
    
    // players sprite node
    var sprite: SKSpriteNode?
    
    // The color of the player
    let color: BlockColor
    
    // The blocks comprising the players path
    var blocks = Array<Block>()
    
    // The column and row representing the players current point
    var column, row: Int
    
    // The players score
    var score = 0
    
    // Hashable
    var hashValue: Int {
        return blocks.reduce(0) { $0.hashValue ^ $1.hashValue }
    }
    
    // Printable
    var description:String {
        return "\(color) player current block: \(blocks[0])"
    }
    
    init(column: Int, row: Int, color: BlockColor) {
        self.color = color
        self.column = column
        self.row = row
    }
    
    final func makeMove() {
    }
    
    final func moveDownByOneRow() {
        shiftBy(0, rows:1)
    }
    
    final func moveUpByOneRow() {
        shiftBy(0, rows:-1)
    }
    
    final func moveRightByOneColumn() {
        shiftBy(1, rows:0)
    }
    
    final func moveLeftByOneColumn() {
        shiftBy(-1, rows:0)
    }
    
    final func shiftBy(_ columns: Int, rows: Int) {
        self.column += columns
        self.row += rows
        for block in blocks {
            block.column += columns
            block.row += rows
        }
    }
    
    final func moveTo(_ column: Int, row:Int) {
        self.column = column
        self.row = row
        makeMove()
    }
    
    final class func randomCorner(notEqualTo corner: (Int, Int)?) -> (Int, Int) {
        
        let randomCol = cornerIndexes.sample()
        let randomRow = cornerIndexes.sample()
        
        if let corner = corner, (randomCol, randomRow) == corner {
            randomCorner(notEqualTo: corner)
        }
        
        return (randomCol, randomRow)
    }
}

func ==(lhs: Player, rhs: Player) -> Bool {
    return lhs.row == rhs.row && lhs.column == rhs.column
}
