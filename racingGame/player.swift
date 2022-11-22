//
//  player.swift
//  racingGame
//
//  Created by Евгений Буракевич on 21.08.22.
//

import SpriteKit

class Player: SKSpriteNode {
    
    var isMoveSide = false
    
    init() {
        let texture = SKTexture(imageNamed: "player")
        super.init(texture: texture, color: .clear, size: texture.size())
        name = "Player"
        zPosition = 1.0
//        setScale(0.75)
        
        physicsBody = SKPhysicsBody(rectangleOf: size)
        physicsBody!.affectedByGravity = false
        physicsBody!.categoryBitMask = PhysicsCategory.player
        physicsBody!.collisionBitMask = PhysicsCategory.car
        physicsBody!.contactTestBitMask = PhysicsCategory.car | PhysicsCategory.score
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension Player {
    func setupPlayer(_ ground: Ground, scene: SKScene) {
        position = CGPoint(x: (scene.frame.width + ground.frame.width + frame.width)/1.65, y: scene.frame.height/4.0)
        
        scene.addChild(self)
//        setupAnim()
    }
//    func setupAnim() {
//        var textures: [SKTexture] = []
//
//        for i in 1...2 {
//            textures.append(SKTexture(imageNamed: "car\(i)"))
//        }
//        run(.repeatForever(.animate(with: textures, timePerFrame: 0.10)))
//    }
    
    func setupMoveSide() {
        isMoveSide = !isMoveSide
        let scale: CGFloat
        
        if isMoveSide {
            scale = -1.0
        } else {
            scale = 1.0
        }
        
//        let flipY = SKAction.scaleX(to: scale, duration: 0.5)
//        run(flipY)
        
        let moveBy = SKAction.moveBy(x: scale*(frame.width*4), y: 0.0, duration: 0.1)
        run(moveBy)
    }
}
