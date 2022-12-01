//
//  ScoreGenerator.swift
//  racingGame
//
//  Created by Evgeny Burakevich on 21.08.22.
//

import Foundation

class ScoreGenerator {
    
    static let sharedInstance = ScoreGenerator()
    private init() {}
    static let keyHighscore = "keyHighscore"
    func setHighscore(_ highscore: Int) {
        UserDefaults.standard.set(highscore, forKey: ScoreGenerator.keyHighscore)
    }
    func getHighscore() -> Int {
        return UserDefaults.standard.integer(forKey: ScoreGenerator.keyHighscore)
    }
}
