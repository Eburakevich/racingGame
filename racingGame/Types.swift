//
//  Types.swift
//  racingGame
//
//  Created by Evgeny Burakevich on 21.08.22.
//

import Foundation

struct PhysicsCategory {
    static let player: UInt32 = 0b1
    static let car: UInt32 = 0b10
    static let score: UInt32 = 0b100
}
enum GameState: Int {
    case initial = 0, start, play, dead
}


