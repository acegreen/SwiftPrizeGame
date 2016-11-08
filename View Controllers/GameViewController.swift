//
//  GameViewController
//  SwiftPrizeGame
//
//  Created by Ace Green on 11/7/16.
//  Copyright © 2016 Ace Green. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController, GameDelegate {
    
    @IBOutlet var gameSceneView: UIView!
    
    @IBOutlet var playerOneScoreLabel: UILabel!
    @IBOutlet var playerTwoScoreLabel: UILabel!
    
    var scene: GameScene!
    var game: Game!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure the view.
        let skView = gameSceneView as! SKView
        skView.isMultipleTouchEnabled = false
        
        // Create and configure the scene.
        scene = GameScene(size: skView.bounds.size)
        scene.scaleMode = .aspectFill
        scene.tick = didTick
        
        game = Game()
        game.delegate = self
        scene.game = game
        
        scene.addTiles()
        
        // add players to scene
        scene.addPlayer(player: game.playerOne)
        scene.addPlayer(player: game.playerTwo)
        
        // add prize
        scene.addPrize(prize: game.prize)
        
        // Present the scene.
        skView.presentScene(scene)
        
        game.beginGame()
    }
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
    
    func didTick() {
        
        // make a move for the right player
        game.currentPlayer.makeMove(towards: game.prize)
        scene.movePlayer(player: game.currentPlayer)
        
        game.currentPlayer = game.returnOtherPlayer(currentPlayer: game.currentPlayer)
    }
    
    func gameDidBegin(game: Game) {
        
        // update scores
        playerOneScoreLabel.text = String(game.playerOne.score)
        playerTwoScoreLabel.text = String(game.playerTwo.score)
        
        // set tick length
        scene.tickLengthMillis = tickLength
        
        scene.startTicking()
    }
    
    func gameDidEnd(game: Game) {
        
        
        scene.stopTicking()
        
        // reset game
        game.resetGame()
        
        game.playerOne.sprite?.position = scene.pointFor(column: game.playerOne.column, row: game.playerOne.row)
        game.playerTwo.sprite?.position = scene.pointFor(column: game.playerTwo.column, row: game.playerTwo.row)
        game.prize.sprite?.position = scene.pointFor(column: game.prize.column, row: game.prize.row)
        
        // begin new game
        game.beginGame()
    }
    
    func gameDidMakeMove(game: Game) {
        
        // Add stuff to reflect player move on game
        
        print("gameDidMakeMove")
    }
}

