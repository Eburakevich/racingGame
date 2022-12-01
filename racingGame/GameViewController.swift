//
//  GameViewController.swift
//  racingGame
//
//  Created by Evgeny Burakevich on 21.08.22.
//

import UIKit
import SpriteKit
import GameplayKit
import SceneKit

class GameViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let scene = GameScene(size: CGSize(width: 1536.0, height: 2048.0))
        scene.scaleMode = .aspectFill
        let skView = view as! SKView
        skView.ignoresSiblingOrder = true
        skView.presentScene(scene)
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
