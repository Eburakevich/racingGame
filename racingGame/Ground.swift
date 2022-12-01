//
//  Ground.swift
//  racingGame
//
//  Created by Evgeny Burakevich on 21.08.22.
//

import SpriteKit
class Ground: SKSpriteNode {
    
    init() {
        let texture = SKTexture(imageNamed: "ground")
        super.init(texture: texture, color: .clear, size: texture.size())
        name = "ground"
        zPosition = -1.0
        anchorPoint = CGPoint(x: 0.5, y: 0.0)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension Ground {
    func setupGround(_ scene: SKScene) {
        for i in 0...2 {
            let ground = Ground()
            ground.position = CGPoint(x: scene.frame.size.width/2.0, y: CGFloat(i)*ground.frame.size.height)
            scene.addChild(ground)
        }
    }
    
    func moveGround(_ scene: GameScene) {
        scene.enumerateChildNodes(withName: "ground") { (node, _) in
            let node = node as! SKSpriteNode
            node.position.y -= scene.moveSpeed
            if node.position.y < -scene.frame.height {
                node.position.y += scene.frame.height*2.0
            }
        }
    }
}
