//
//  GameScene.swift
//  racingGame
//
//  Created by Evgeny Burakevich on 21.08.22.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var playerNode = Player()
    var groundNode = Ground()
    var moveSpeed: CGFloat = 8.0
    var hud = HUD()
    var carTimer: Timer?
    var numScore = 0
    var gameState: GameState = .initial {
        didSet {
            hud.setupGameState(from: oldValue, to: gameState)
        }
    }
    
    override func didMove(to view: SKView) {
        backgroundColor = .gray
        if gameState == .initial {
        setupNodes()
        setupPhysics()
            gameState = .start
    }
    }
    override func update(_ currentTime: TimeInterval) {
        
        if gameState != .play {
           isPaused = true
            return
        }
        
        groundNode.moveGround(self)
        moveCar()
    }
}

extension GameScene {
    func setupNodes() {
        groundNode.setupGround(self)
        playerNode.setupPlayer(groundNode, scene: self)
        setupHUD()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        guard let touch = touches.first else { return }
        let node = atPoint(touch.location(in: self))
        if node.name == HUDSettings.tapToStart {
            gameState = .play
            isPaused = false
            setupTimer()
        } else if node.name == HUDSettings.gameOver {
           let scene = GameScene(size: size)
            scene.scaleMode = scaleMode
            view!.presentScene(scene, transition: .fade(withDuration: 0.5))
        } else {
            playerNode.setupMoveSide()
        }
    }
    
    func setupPhysics() {
        physicsWorld.contactDelegate = self
    }
    func setupTimer() {
        var carRandom = CGFloat.random(min: 1.5, max: 2.5)
        run(.repeatForever(.sequence([.wait(forDuration: 5.0), .run {
            carRandom -= 1.0}
                                     ])))
        carTimer = Timer.scheduledTimer(timeInterval: TimeInterval(carRandom), target: self, selector: #selector(spawnCars), userInfo: nil, repeats: true)
    }
    
    @objc func spawnCars() {
        let scale: CGFloat
        if Int(arc4random_uniform(UInt32(2))) == 0 {
            scale = -1.0
        } else {
            scale = 1.0
        }
        let car = SKSpriteNode(imageNamed: "car").copy() as! SKSpriteNode
        car.name = "car"
        car.zPosition = 2.0
        let value: CGFloat = (car.frame.width + groundNode.frame.width)
        let carPosX = frame.width/2.0 + (value/0.6 * scale)
        car.position = CGPoint(x: carPosX,
                               y: size.height + car.frame.height)
        car.physicsBody = SKPhysicsBody(rectangleOf: car.size)
        car.physicsBody!.isDynamic = false
        car.physicsBody!.categoryBitMask = PhysicsCategory.car
        addChild(car)
        car.run(.sequence([.wait(forDuration: 8.0)]))
        let score = SKSpriteNode(texture: nil, color: .systemYellow, size: CGSize(width: 50, height: 50)).copy() as! SKSpriteNode
        score.name = "Score"
        score.zPosition = 5.0
        let scorePosX = frame.width/2.0 + (value/0.6 * (-scale))
        score.position = CGPoint(x: scorePosX, y: car.position.y + score.frame.height)
        score.physicsBody = SKPhysicsBody(rectangleOf: score.size)
        score.physicsBody!.isDynamic = false
        score.physicsBody!.categoryBitMask = PhysicsCategory.score
        addChild(score)
    }
    
    func moveCar() {
        enumerateChildNodes(withName: "car") { (node, _) in
            let node = node as! SKSpriteNode
            node.position.y -= self.moveSpeed
        }
        enumerateChildNodes(withName: "Score") { (node, _) in
            let node = node as! SKSpriteNode
            node.position.y -= self.moveSpeed
        }
        
    }
   func setupHUD() {
        addChild(hud)
       hud.setupScoreLabel(numScore)
       hud.setupHighScoreLabel(ScoreGenerator.sharedInstance.getHighscore())
   }
    
    func gameOver() {
        playerNode.removeFromParent()
        carTimer?.invalidate()
        gameState = .dead
        isPaused = true
        let highscore = ScoreGenerator.sharedInstance.getHighscore()
        if numScore > highscore {
            ScoreGenerator.sharedInstance.setHighscore(numScore)
        }
       
    }
}

extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        let other = contact.bodyA.categoryBitMask == PhysicsCategory.player ? contact.bodyB : contact.bodyA
        switch other.categoryBitMask {
        case PhysicsCategory.car:
        gameOver()
        case PhysicsCategory.score:
            if let node = other.node {
                numScore += 1
                hud.scoreLabel.text = "Score: \(numScore)"
                if numScore % 4 == 0 {
                    moveSpeed += 2.5
                }
                node.removeFromParent()
            }
        default: break
        }
    }
}
