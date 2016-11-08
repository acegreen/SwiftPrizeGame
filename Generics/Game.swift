//
//  Game.swift
//  SwiftPrizeGame
//
//  Created by Ace Green on 11/7/16.
//  Copyright © 2016 Ace Green. All rights reserved.
//

import UIKit

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
    
    var prize: Prize
    
    var currentPlayer: Player
    
    var blocksArray: Array2D<Block>
    
    init() {
        
        // setup players
        let playerOneCornerCord = Player.randomCorner(notEqualTo: nil)
        let playerTwoCornerCord = Player.randomCorner(notEqualTo: playerOneCornerCord)
        playerOne = Player(column: playerOneCornerCord.0, row: playerOneCornerCord.1, color: .red)
        playerTwo = Player(column: playerTwoCornerCord.0, row: playerTwoCornerCord.1, color: .blue)
        
        // setup price
        let prizeCord = Prize.random()
        prize = Prize(column: prizeCord.0, row: prizeCord.1)
        
        // make player one current player (could add a randomizer here)
        currentPlayer = playerOne
        
        blocksArray = Array2D<Block>(columns: NumColumns, rows: NumRows)
    }
    
    func beginGame() {
        
        // send info to delegate
        delegate?.gameDidBegin(game: self)
    }
    
    func endGame() {
        
        // send info to delegate
        delegate?.gameDidEnd(game: self)
    }
    
    func resetGame() {
        
        let playerOneCornerCord = Player.randomCorner(notEqualTo: nil)
        let playerTwoCornerCord = Player.randomCorner(notEqualTo: playerOneCornerCord)
        
        playerOne.sprite?.position = CGPoint(x: playerOneCornerCord.0, y: playerOneCornerCord.1)
        playerTwo.sprite?.position = CGPoint(x: playerTwoCornerCord.0, y: playerTwoCornerCord.1)
        
        let prizeCord = Prize.random()
        prize.sprite?.position = CGPoint(x: prizeCord.0, y: prizeCord.1)
    }
    
    func blockAt(column: Int, row: Int) -> Block? {
        assert(column >= 0 && column < NumColumns)
        assert(row >= 0 && row < NumRows)
        return blocksArray[column, row]
    }
    
    func detectIllegalMove() -> Bool {
        
        let currentPlayersCurrentPosition = (currentPlayer.column, currentPlayer.row)
        let otherPlayer = returnOtherPlayer(currentPlayer: currentPlayer)
        
        for block in otherPlayer.blocks {
            if block.column == currentPlayersCurrentPosition.0 && block.row == currentPlayersCurrentPosition.0 {
                return true
            }
        }
        
        return false
    }
    
    func returnOtherPlayer(currentPlayer: Player) -> Player {
        return currentPlayer == playerOne ? playerTwo : playerOne
    }
}


