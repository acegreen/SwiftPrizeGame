//
//  Player.swift
//  SwiftPrizeGame
//
//  Created by Ace Green on 11/7/16.
//  Copyright © 2016 Ace Green. All rights reserved.
//

import SpriteKit

class Player: CustomStringConvertible {
    
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
    
    // Printable
    var description: String {
        return "\(color) player current block: \(blocks[0])"
    }
    
    init(column: Int, row: Int, color: BlockColor) {
        self.color = color
        self.column = column
        self.row = row
        
        let intialBlock = Block(column: column, row: row, color: color)
        self.blocks.insert(intialBlock, at: 0)
    }
    
    final func makeMove(towards prize: Prize) {
        
        let (prizeCol, prizeRow) = (prize.column, prize.row)
        
        guard (prizeCol, prizeRow) != (column, row) else { return }
        
        if prizeCol > column {
            moveRightByOneColumn()
        } else if prizeCol < column {
            moveLeftByOneColumn()
        } else if prizeRow < row {
            moveUpByOneRow()
        } else if prizeRow > row {
            moveDownByOneRow()
        }
    }
    
    final func moveDownByOneRow() {
        shiftBy(0, rows: 1)
    }
    
    final func moveUpByOneRow() {
        shiftBy(0, rows: -1)
    }
    
    final func moveRightByOneColumn() {
        shiftBy(1, rows: 0)
    }
    
    final func moveLeftByOneColumn() {
        shiftBy(-1, rows: 0)
    }
    
    final func shiftBy(_ columns: Int, rows: Int) {
        self.column += columns
        self.row += rows
        
        let oldBlock = blocks[0]
        oldBlock.color = .orange
        
        let newBlock = Block(column: self.column, row: self.row, color: .red)
        blocks.insert(newBlock, at: 0)
        
        print(column, row)
    }
    
    final class func randomCorner(notEqualTo corner: (Int, Int)?) -> (Int, Int) {
        
        let randomCol = Constants.cornerIndexes.sample()
        let randomRow = Constants.cornerIndexes.sample()
        
        guard let corner = corner, (randomCol, randomRow) == corner else { return (randomCol, randomRow) }
        
        return randomCorner(notEqualTo: corner)
    }
}

func ==(lhs: Player, rhs: Player) -> Bool {
    return lhs.row == rhs.row && lhs.column == rhs.column
}
