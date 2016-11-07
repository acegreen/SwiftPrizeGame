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
        
        scene.addBlocks()
        
        game.beginGame()
        
        // Present the scene.
        skView.presentScene(scene)
    }
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
    
    func didTick() {
        
        // make a move for the right player
    }
    
    func nextPlayer() {
    }
    
    func gameDidBegin(game: Game) {
        
        // update scores
        playerOneScoreLabel.text = String(game.playerOne.score)
        playerTwoScoreLabel.text = String(game.playerTwo.score)
        
        // set tick length
        scene.tickLengthMillis = tickLength
        
        // add players to scene
        scene.addSprite(player: game.playerOne)
        scene.addSprite(player: game.playerTwo)
    }
    
    func gameDidEnd(game: Game) {
        view.isUserInteractionEnabled = false
        scene.stopTicking()
        
        // play endgame sound
        //scene.playSound("Sounds/gameOver.mp3")
        
        // begin new game
        game.beginGame()
    }
    
    func gameDidMakeMove(game: Game) {
        
        
    }
}

