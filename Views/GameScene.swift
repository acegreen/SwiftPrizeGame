//
//  GameScene.swift
//  SwiftPrizeGame
//
//  Created by Ace Green on 11/7/16.
//  Copyright © 2016 Ace Green. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var game: Game!
    
    let gameLayer = SKNode()
    let tileLayer = SKNode()
    
    var tick:(() -> ())?
    var tickLengthMillis = Constants.tickLength
    var lastTick: Date?
    
    var textureCache = Dictionary<String, SKTexture>()
    
    override init(size: CGSize) {
        super.init(size: size)
        
        // set anchor point to center
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        // set backgrond color to white
        self.backgroundColor = .white
        
        addChild(gameLayer)
        
        let layerPosition = CGPoint(
            x: -Constants.tileSize - (4 * Constants.titleSpace) * CGFloat(Constants.numColumns) / 2,
            y: -Constants.tileSize - (4 * Constants.titleSpace) * CGFloat(Constants.numRows) / 2)
        
        tileLayer.position = layerPosition
        gameLayer.addChild(tileLayer)
        
        // play game sound
        run(SKAction.repeatForever(SKAction.playSoundFileNamed("gameSound.mp3", waitForCompletion: true)))
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoder not supported")
    }
    
    func addTiles() {
        for row in 0..<Constants.numRows {
            for column in 0..<Constants.numColumns {
                if game.blockAt(column: column, row: row) == nil {
                    let tileNode = SKSpriteNode(imageNamed: "tile")
                    tileNode.size = CGSize(width: Constants.tileSize, height: Constants.tileSize)
                    tileNode.position = pointFor(column: column, row: row)
                    tileLayer.addChild(tileNode)
                }
            }
        }
    }
    
    func addPlayer(player: Player) {

        var texture = textureCache[player.color.spriteName]
        
        if texture == nil {
            texture = SKTexture(imageNamed: player.color.spriteName)
            textureCache[player.color.spriteName] = texture
        }
        
        let sprite = SKSpriteNode(texture: texture)
        sprite.size = CGSize(width: Constants.tileSize * 0.75, height: Constants.tileSize * 0.75)
        sprite.position = pointFor(column: player.column, row: player.row)
        tileLayer.addChild(sprite)
        player.sprite = sprite
    }
    
    func addPrize(prize: Prize) {
        
        var texture = textureCache[prize.spriteName]
        
        if texture == nil {
            texture = SKTexture(imageNamed: prize.spriteName)
            textureCache[prize.spriteName] = texture
        }
        
        let sprite = SKSpriteNode(texture: texture)
        sprite.size = CGSize(width: Constants.tileSize * 0.75, height: Constants.tileSize * 0.75)
        sprite.position = pointFor(column: prize.column, row: prize.row)
        tileLayer.addChild(sprite)
        prize.sprite = sprite
    }
    
    final func movePlayer(player: Player) {
        
        guard !game.detectIllegalMove(by: player) else { return }
        
        player.sprite?.position = pointFor(column: player.column, row: player.row)
        
        if (player.column, player.row) == (game.prize.column, game.prize.row) {
            player.score += 1
            // play endgame sound
            playSound(sound: "score.mp3")
            game.endGame()
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        /* Called before each frame is rendered */
        guard let lastTick = lastTick else {
            return
        }
        let timePassed = lastTick.timeIntervalSinceNow * -1000.0
        if timePassed > tickLengthMillis {
            self.lastTick = Date()
            tick?()
        }
    }
    
    func startTicking() {
        lastTick = Date()
    }
    
    func stopTicking() {
        lastTick = nil
    }
    
    func pointFor(column: Int, row: Int) -> CGPoint {
        return CGPoint(
            x: CGFloat(column) * (Constants.tileSize + Constants.titleSpace) + (Constants.tileSize + Constants.titleSpace)/2,
            y: CGFloat(row) * (Constants.tileSize + Constants.titleSpace) + (Constants.tileSize + Constants.titleSpace)/2)
    }
    
    func playSound(sound: String) {
        run(SKAction.playSoundFileNamed(sound, waitForCompletion: false))
    }
}
