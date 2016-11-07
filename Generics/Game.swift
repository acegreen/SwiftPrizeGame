//
//  Game.swift
//  SwiftPrizeGame
//
//  Created by Ace Green on 11/7/16.
//  Copyright © 2016 Ace Green. All rights reserved.
//

let NumColumns = 5
let NumRows = 5

protocol GameDelegate {
    func gameDidBegin(game: Game)
    func gameDidEnd(game: Game)
    func gameDidMakeMove(game: Game)
}

class Game {
    
    var delegate:GameDelegate?
    
    var playerOne: Player
    var playerTwo: Player
    
    var currentPlayer: Player
    
    var blocksArray: Array2D<Block>
    
    init() {
        
        let playerOneCornerCord = Player.randomCorner(notEqualTo: nil)
        let playerTwoCornerCord = Player.randomCorner(notEqualTo: playerOneCornerCord)
        
        playerOne = Player(column: playerOneCornerCord.0, row: playerOneCornerCord.1, color: .red)
        playerTwo = Player(column: playerTwoCornerCord.0, row: playerTwoCornerCord.1, color: .blue)
        
        currentPlayer = playerOne
        blocksArray = Array2D<Block>(columns: NumColumns, rows: NumRows)
        
    }
    
    func beginGame() {
        delegate?.gameDidBegin(game: self)
    }
    
    func endGame() {
        
        // do some reset stuff here
        
        // send info to delegate
        delegate?.gameDidEnd(game: self)
    }
    
    func blockAt(column: Int, row: Int) -> Block? {
        assert(column >= 0 && column < NumColumns)
        assert(row >= 0 && row < NumRows)
        return blocksArray[column, row]
    }
    
    func detectIllegalPlacement() -> Bool {
        
        let currentPlayersCurrentPosition = (currentPlayer.column, currentPlayer.row)
        let otherPlayer = currentPlayer == playerOne ? playerTwo : playerOne
        
        for block in otherPlayer.blocks {
            if block.column == currentPlayersCurrentPosition.0 && block.row == currentPlayersCurrentPosition.0 {
                return true
            }
        }
        
        return false
    }
}


