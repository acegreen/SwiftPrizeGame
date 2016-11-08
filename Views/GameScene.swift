//
//  GameScene.swift
//  SwiftPrizeGame
//
//  Created by Ace Green on 11/7/16.
//  Copyright © 2016 Ace Green. All rights reserved.
//

import SpriteKit

let blockSize: CGFloat = 50.0
let blockSpace: CGFloat = 10.0

let tickLength = TimeInterval(1000)

class GameScene: SKScene {
    
    var game: Game!
    
    let gameLayer = SKNode()
    let blockLayer = SKNode()
    
    var tick:(() -> ())?
    var tickLengthMillis = tickLength
    var lastTick:Date?
    
    var textureCache = Dictionary<String, SKTexture>()
    
    override init(size: CGSize) {
        super.init(size: size)
        
        // set anchor point to center
        anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        // set backgrond color to white
        self.backgroundColor = .white
        
        addChild(gameLayer)
        
        let layerPosition = CGPoint(
            x: -blockSize - (4 * blockSpace) * CGFloat(NumColumns) / 2,
            y: -blockSize - (4 * blockSpace) * CGFloat(NumRows) / 2)
        
        blockLayer.position = layerPosition
        gameLayer.addChild(blockLayer)
        
        // play game sound
        //run(SKAction.repeatForever(SKAction.playSoundFileNamed("gameSound.mp3", waitForCompletion: true)))
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("NSCoder not supported")
    }
    
    func addBlocks() {
        for row in 0..<NumRows {
            for column in 0..<NumColumns {
                if game.blockAt(column: column, row: row) == nil {
                    let blockNode = SKSpriteNode(imageNamed: "block")
                    blockNode.size = CGSize(width: blockSize, height: blockSize)
                    blockNode.position = pointFor(column: column, row: row)
                    blockLayer.addChild(blockNode)
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
        sprite.size = CGSize(width: blockSize * 0.75, height: blockSize * 0.75)
        sprite.position = pointFor(column: player.column, row: player.row)
        blockLayer.addChild(sprite)
        player.sprite = sprite
    }
    
    func addPrize(prize: Prize) {
        
        var texture = textureCache[prize.spriteName]
        
        if texture == nil {
            texture = SKTexture(imageNamed: prize.spriteName)
            textureCache[prize.spriteName] = texture
        }
        
        let sprite = SKSpriteNode(texture: texture)
        sprite.size = CGSize(width: blockSize * 0.75, height: blockSize * 0.75)
        sprite.position = pointFor(column: prize.column, row: prize.row)
        blockLayer.addChild(sprite)
        prize.sprite = sprite
    }
    
    final func movePlayer(player: Player) {
        player.sprite?.position = pointFor(column: player.column, row: player.row)
        
        if (player.column, player.row) == (game.prize.column, game.prize.row) {
            player.score += 1
            game.endGame()
        }
    }
    
    func playSound(_ sound: String) {
        run(SKAction.playSoundFileNamed(sound, waitForCompletion: false))
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
            x: CGFloat(column) * (blockSize + blockSpace) + (blockSize + blockSpace)/2,
            y: CGFloat(row) * (blockSize + blockSpace) + (blockSize + blockSpace)/2)
    }
}
