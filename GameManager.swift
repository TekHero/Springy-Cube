//
//  GameManager.swift
//  Springy Cube
//
//  Created by Brian Lim on 7/10/16.
//  Copyright © 2016 codebluapps. All rights reserved.
//

import Foundation
import SpriteKit

struct ColliderType {
    
    static let Barrier: UInt32 = 1
    static let Player: UInt32 = 2
    static let Obstacle: UInt32 = 3
    static let ScoreDetector: UInt32 = 4
}

class GameManager {
    
    static var instance = GameManager()
    fileprivate init() {}
    
    func randomBetweenNumbers(_ firstNum: CGFloat, secondNum: CGFloat) -> CGFloat {
        
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
    }
    
    // Saving and Grabbing highscores
    func setHighscore(_ highscore: Int) {
        UserDefaults.standard.set(highscore, forKey: "HIGHSCORE")
    }
    
    func getHighscore() -> Int {
        return UserDefaults.standard.integer(forKey: "HIGHSCORE")
    }
    
}
