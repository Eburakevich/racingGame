//
//  HUD.swift
//  racingGame
//
//  Created by Евгений Буракевич on 21.08.22.
//

import SpriteKit

enum HUDSettings {
    
    static let score = "Score:"
    static let highScore = "Higscore:"
    static let tapToStart = "Tap To Start"
    static let gameOver = "Game Over"
}

class HUD: SKNode {
    
    var scoreLabel: SKLabelNode!
    var higshscoreLabel: SKLabelNode!
  
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addLabel(_ name: String, text: String, fontSize: CGFloat, pos: CGPoint) {
        let label = SKLabelNode()
        label.name = name
        label.text = text
        label.fontSize = fontSize
        label.position = pos
        label.zPosition = 50.0
    

        addChild(label)
    }
    func setupScoreLabel(_ score: Int) {
        guard let scene = scene as? GameScene else { return }
        let pos = CGPoint(x: scene.frame.midX + scene.frame.width/48, y: scene.frame.midY + scene.frame.height/4)
        addLabel(HUDSettings.score, text: "Score: \(score)", fontSize: 70.0, pos: pos)
        scoreLabel = childNode(withName: HUDSettings.score) as? SKLabelNode
        scoreLabel.horizontalAlignmentMode = .left
        scoreLabel.verticalAlignmentMode = .top
    }
    func setupHighScoreLabel(_ highscore: Int) {
        guard let scene = scene as? GameScene else { return }
        let pos = CGPoint(x: scene.frame.midX + scene.frame.width/48, y: scene.frame.midY + scene.frame.height/4 - 80)
        addLabel(HUDSettings.highScore, text: "HighScore: \(highscore)", fontSize: 70.0, pos: pos)
        higshscoreLabel = childNode(withName: HUDSettings.highScore) as? SKLabelNode
        higshscoreLabel.horizontalAlignmentMode = .left
        higshscoreLabel.verticalAlignmentMode = .top
    }
    func addLabel(fontSize: CGFloat, name: String, text: String) {
        guard let scene = scene as? GameScene else { return }
        let pos = CGPoint(x: scene.frame.width/2.0, y: scene.frame.height/2.0 + 100.0)
        addLabel(name, text: text, fontSize: fontSize, pos: pos)
    }
    func setupGameState(from: GameState, to: GameState) {
        clearUI(gameState: from)
        updateUI(gameState: to)
    }
    func updateUI(gameState: GameState) {
        switch gameState {
        case .start:
            addLabel(fontSize: 150.0, name: HUDSettings.tapToStart, text: HUDSettings.tapToStart)
        case .dead:
            addLabel(fontSize: 200.0, name: HUDSettings.gameOver, text: HUDSettings.gameOver)
        default: break
        }
    }
    func clearUI(gameState: GameState) {
        switch gameState {
        case .start:
            childNode(withName: HUDSettings.tapToStart)?.removeFromParent()
        case .dead:
            childNode(withName: HUDSettings.gameOver)?.removeFromParent()
        default: break
        }
    }
    
}
