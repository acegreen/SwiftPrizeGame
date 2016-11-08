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
    
    var blocks: Array2D<Block>
    
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
        
        blocks = Array2D<Block>(columns: NumColumns, rows: NumRows)
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
        (playerOne.column, playerOne.row) = playerOneCornerCord
        
        let playerTwoCornerCord = Player.randomCorner(notEqualTo: playerOneCornerCord)
        (playerTwo.column, playerTwo.row) = playerTwoCornerCord
        
        let prizeCord = Prize.random()
        (prize.column, prize.row) = prizeCord
    }
    
    func blockAt(column: Int, row: Int) -> Block? {
        assert(column >= 0 && column < NumColumns)
        assert(row >= 0 && row < NumRows)
        return blocks[column, row]
    }
    
    func detectIllegalMove(by player: Player) -> Bool {
        
        let otherPlayer = returnOtherPlayer(currentPlayer: currentPlayer)
        
        if (player.column, player.row) == (otherPlayer.column, otherPlayer.row) {
            return true
        }
        
        return false
    }
    
    func returnOtherPlayer(currentPlayer: Player) -> Player {
        return currentPlayer == playerOne ? playerTwo : playerOne
    }
}


