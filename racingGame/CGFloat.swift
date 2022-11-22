//
//  CGFloat.swift
//  racingGame
//
//  Created by Евгений Буракевич on 21.08.22.
//

import CoreGraphics

extension CGFloat {
    
    static func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / Float(0xFFFFFFFF))
    }
    
    static func random(min: CGFloat, max: CGFloat) -> CGFloat {
    assert(min < max)
    return CGFloat.random() * (max - min) + min
    }
}
