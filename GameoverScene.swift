//
//  GameoverScene.swift
//  Springy Cube
//
//  Created by Brian Lim on 7/14/16.
//  Copyright © 2016 codebluapps. All rights reserved.
//

import Foundation
import SpriteKit

class GameoverScene: SKScene {
    
    var musicBtn = SKSpriteNode()
    var rateBtn = SKSpriteNode()
    var homeBtn = SKSpriteNode()
    var retryBtn = SKSpriteNode()
    var titleLbl = SKLabelNode()
    
    var leftGreen = SKSpriteNode()
    var leftBlue = SKSpriteNode()
    var leftRed = SKSpriteNode()
    
    var rightGreen = SKSpriteNode()
    var rightBlue = SKSpriteNode()
    var rightRed = SKSpriteNode()
    
    var redLevel = SKNode()
    var blueLevel = SKNode()
    var greenLevel = SKNode()
    
    var scoreTitleLbl = SKLabelNode()
    var scoreLbl = SKLabelNode()
    
    var recordTitleLbl = SKLabelNode()
    var recordLbl = SKLabelNode()
    
    var userScore = 0
    var userHighscore = 0
    
    var shouldAnimate = false
    
    override func didMove(to view: SKView) {
        adShown += 1
        
        checkScore()
        initialize()
        waitBeforeShowingAd()
        
        if soundOn == true {
            
            musicBtn.run(SKAction.setTexture(SKTexture(imageNamed: "MusicBtnOn")))
        } else {
            
            musicBtn.run(SKAction.setTexture(SKTexture(imageNamed: "MusicBtnOff")))
        }
    }
    
    func initialize() {
        
        createTitleLbl()
        createRedLevel()
        createBlueLevel()
        createGreenLevel()
        createScoreAndTitleLabels()
        createRecordAndTitleLabels()
        createRetryBtn()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            
            let location = touch.location(in: self)
            
            if atPoint(location) == rateBtn {
                
                rateBtn.texture = SKTexture(imageNamed: "RateBtnDown")
            }
            
            if atPoint(location) == homeBtn {
                
                homeBtn.texture = SKTexture(imageNamed: "HomeBtnDown")
            }
            
            if atPoint(location) == retryBtn {
                
                retryBtn.texture = SKTexture(imageNamed: "RetryBtnDown")
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            
            let location = touch.location(in: self)
            
            if atPoint(location) == musicBtn {
                
                soundBtnPressed()
            }
            
            if atPoint(location) == rateBtn {
                
                rateBtn.texture = SKTexture(imageNamed: "RateBtn")
                
                rateBtnPressed()
            }
            
            if atPoint(location) == homeBtn {
                
                homeBtn.texture = SKTexture(imageNamed: "HomeBtn")
                
                let home = MainMenuScene(fileNamed: "MainMenuScene")
                home?.scaleMode = .aspectFill
                self.view?.presentScene(home!, transition: SKTransition.fade(withDuration: 0.3))
            }
             
            if atPoint(location) == retryBtn {
                
                retryBtn.texture = SKTexture(imageNamed: "RetryBtn")
                
                let gameplay = GameplayScene(fileNamed: "GameplayScene")
                gameplay?.scaleMode = .aspectFill
                self.view?.presentScene(gameplay!, transition: SKTransition.fade(withDuration: 0.3))
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            
            let location = touch.location(in: self)
    
            if atPoint(location) == rateBtn {
                
                rateBtn.texture = SKTexture(imageNamed: "RateBtn")
            }
            
            if atPoint(location) == homeBtn {
                
                homeBtn.texture = SKTexture(imageNamed: "HomeBtn")
            }
            
            if atPoint(location) == retryBtn {
                
                retryBtn.texture = SKTexture(imageNamed: "RetryBtn")
            }
        }
    }
    
    func checkScore() {
        
        // Checking to see if there is a integer for the key "SCORE"
        if let score: Int = UserDefaults.standard.integer(forKey: "SCORE") {
            userScore = score
            
            // Checking to see if there if a integer for the key "HIGHSCORE"
            if let highscore: Int = UserDefaults.standard.integer(forKey: "HIGHSCORE") {
                
                // If there is, check if the current score is greater then the value of the current highscore
                if score > highscore {
                    // If it is, set the current score as the new high score
                    GameManager.instance.setHighscore(score)
                    userHighscore = score
                    shouldAnimate = true
                    
                } else {
                    // Score is not greater then highscore
                }
            } else {
                // There is no integer for the key "HIGHSCORE"
                // Set the current score as the highscore since there is no value for highscore yet
                GameManager.instance.setHighscore(score)
                userHighscore = score
                shouldAnimate = true
                
            }
        }
        
        // Checking to see if there a integer for the key "HIGHSCORE"
        if let highscore: Int = UserDefaults.standard.integer(forKey: "HIGHSCORE") {
            // If so, then set the value of this key to the userHighscore variable
            userHighscore = highscore
        }
        
    }
    
    func createTitleLbl() {
        
        titleLbl = SKLabelNode(fontNamed: "PhosphateInline") // Future-CondensedMedium
        titleLbl.name = "TitleLbl"
        titleLbl.zPosition = 1
        titleLbl.fontColor = SKColor.darkGray
        titleLbl.fontSize = 75
        titleLbl.text = "GAMEOVER"
        titleLbl.position = CGPoint(x: 0, y: -350)
        
        self.addChild(titleLbl)
    }
    
    func createScoreAndTitleLabels() {
        
        scoreTitleLbl = SKLabelNode(fontNamed: "PhosphateInLine")
        scoreTitleLbl.name = "ScoreTitleLbl"
        scoreTitleLbl.zPosition = 1
        scoreTitleLbl.fontColor = SKColor.darkGray
        scoreTitleLbl.fontSize = 120
        scoreTitleLbl.text = "SCORE"
        scoreTitleLbl.position = CGPoint(x: -280, y: titleLbl.position.y - 160)
        
        scoreLbl = SKLabelNode(fontNamed: "PhosphateInLine")
        scoreLbl.name = "ScoreLbl"
        scoreLbl.zPosition = 1
        scoreLbl.fontColor = SKColor.darkGray
        scoreLbl.fontSize = 90
        scoreLbl.text = "\(userScore)"
        scoreLbl.position = CGPoint(x: -280, y: scoreTitleLbl.position.y - 120)
        
        self.addChild(scoreTitleLbl)
        self.addChild(scoreLbl)
    }
    
    func createRecordAndTitleLabels() {
        
        recordTitleLbl = SKLabelNode(fontNamed: "PhosphateInLine")
        recordTitleLbl.name = "RecordTitleLbl"
        recordTitleLbl.zPosition = 1
        recordTitleLbl.fontColor = SKColor.darkGray
        recordTitleLbl.fontSize = 120
        recordTitleLbl.text = "RECORD"
        recordTitleLbl.position = CGPoint(x: 280, y: titleLbl.position.y - 160)
        
        recordLbl = SKLabelNode(fontNamed: "PhosphateInLine")
        recordLbl.name = "RecordLbl"
        recordLbl.zPosition = 1
        recordLbl.fontColor = SKColor.darkGray
        recordLbl.fontSize = 90
        recordLbl.text = "\(userHighscore)"
        recordLbl.position = CGPoint(x: 280, y: recordTitleLbl.position.y - 120)
        if shouldAnimate == true {
            
            let fadeOut = SKAction.fadeAlpha(to: 0.0, duration: 0.5)
            let fadeIn = SKAction.fadeAlpha(to: 1.0, duration: 0.5)
            recordLbl.run(SKAction.repeatForever(SKAction.sequence([fadeOut, fadeIn])))
        }
        
        self.addChild(recordTitleLbl)
        self.addChild(recordLbl)
    }
    
    func createRetryBtn() {
        
        retryBtn = SKSpriteNode(imageNamed: "RetryBtn")
        retryBtn.name = "RetryBtn"
        retryBtn.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        retryBtn.zPosition = 1
        retryBtn.size = CGSize(width: 200, height: 200)
        retryBtn.position = CGPoint(x: 0, y: recordLbl.position.y - 60)
        
        self.addChild(retryBtn)
    }
    
    func createRedLevel() {
        
        redLevel = SKNode()
        redLevel.name = "RedLevel"
        
        leftRed = SKSpriteNode(color: UIColor(red: 255.0 / 255.0, green: 87.0 / 255.0, blue: 87.0 / 255.0, alpha: 1.0), size: CGSize(width: 600, height: 80))
        leftRed.name = "leftRed"
        leftRed.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        leftRed.position = CGPoint(x: -410, y: 0)
        
        rightRed = SKSpriteNode(color: UIColor(red: 255.0 / 255.0, green: 87.0 / 255.0, blue: 87.0 / 255.0, alpha: 1.0), size: CGSize(width: 600, height: 80))
        rightRed.name = "rightRed"
        rightRed.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        rightRed.position = CGPoint(x: 500, y: 0)
        
        homeBtn = SKSpriteNode(imageNamed: "HomeBtn")
        homeBtn.name = "homeBtn"
        homeBtn.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        homeBtn.size = CGSize(width: 160, height: 160)
        homeBtn.position = CGPoint(x: leftRed.position.x + 450, y: leftRed.position.y)
        
        redLevel.zPosition = 1
        redLevel.position = CGPoint(x: 0, y: titleLbl.position.y + 180)
        
        redLevel.addChild(leftRed)
        redLevel.addChild(rightRed)
        redLevel.addChild(homeBtn)
        
        self.addChild(redLevel)
        
        
        let moveLeft = SKAction.moveTo(x: -60, duration: 1.2)
        let moveRight = SKAction.moveTo(x: 60, duration: 1.2)
        
        redLevel.run(SKAction.repeatForever(SKAction.sequence([moveRight, moveLeft])))
        
    }
    
    func createBlueLevel() {
        
        blueLevel = SKNode()
        blueLevel.name = "BlueLevel"
        
        leftBlue = SKSpriteNode(color: UIColor(red: 9.0 / 255.0, green: 194.0 / 255.0, blue: 255.0 / 255.0, alpha: 1.0), size: CGSize(width: 600, height: 80))
        leftBlue.name = "leftBlue"
        leftBlue.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        leftBlue.position = CGPoint(x: -410, y: 0)
        
        rightBlue = SKSpriteNode(color: UIColor(red: 9.0 / 255.0, green: 194.0 / 255.0, blue: 255.0 / 255.0, alpha: 1.0), size: CGSize(width: 600, height: 80))
        rightBlue.name = "rightBlue"
        rightBlue.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        rightBlue.position = CGPoint(x: 500, y: 0)
        
        rateBtn = SKSpriteNode(imageNamed: "RateBtn")
        rateBtn.name = "RateBtn"
        rateBtn.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        rateBtn.size = CGSize(width: 160, height: 160)
        rateBtn.position = CGPoint(x: leftBlue.position.x + 450, y: leftBlue.position.y)
        
        blueLevel.zPosition = 1
        blueLevel.position = CGPoint(x: 0, y: titleLbl.position.y + 600)
        
        blueLevel.addChild(leftBlue)
        blueLevel.addChild(rightBlue)
        blueLevel.addChild(rateBtn)
        
        self.addChild(blueLevel)
        
        let moveLeft = SKAction.moveTo(x: -90, duration: 1.2)
        let moveRight = SKAction.moveTo(x: 90, duration: 1.2)
        
        blueLevel.run(SKAction.repeatForever(SKAction.sequence([moveLeft, moveRight])))
        
    }
    
    func createGreenLevel() {
        
        greenLevel = SKNode()
        greenLevel.name = "GreenLevel"
        
        leftGreen = SKSpriteNode(color: UIColor(red: 126.0 / 255.0, green: 211.0 / 255.0, blue: 33.0 / 255.0, alpha: 1.0), size: CGSize(width: 600, height: 80))
        leftGreen.name = "leftGreen"
        leftGreen.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        leftGreen.position = CGPoint(x: -440, y: 0)
        
        rightGreen = SKSpriteNode(color: UIColor(red: 126.0 / 255.0, green: 211.0 / 255.0, blue: 33.0 / 255.0, alpha: 1.0), size: CGSize(width: 600, height: 80))
        rightGreen.name = "rightGreen"
        rightGreen.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        rightGreen.position = CGPoint(x: 450, y: 0)
        
        musicBtn = SKSpriteNode(imageNamed: "MusicBtn")
        musicBtn.name = "MusicBtn"
        musicBtn.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        musicBtn.size = CGSize(width: 160, height: 160)
        musicBtn.position = CGPoint(x: leftGreen.position.x + 450, y: leftGreen.position.y)
        
        greenLevel.zPosition = 1
        greenLevel.position = CGPoint(x: 0, y: titleLbl.position.y + 1030)
        
        greenLevel.addChild(leftGreen)
        greenLevel.addChild(rightGreen)
        greenLevel.addChild(musicBtn)
        
        self.addChild(greenLevel)
        
        let moveLeft = SKAction.moveTo(x: -100, duration: 1.2)
        let moveRight = SKAction.moveTo(x: 100, duration: 1.2)
        
        greenLevel.run(SKAction.repeatForever(SKAction.sequence([moveRight, moveLeft])))
    }
    
    func waitBeforeShowingAd() {
        let wait = SKAction.wait(forDuration: 0.5)
        let run = SKAction.run {
            
            NotificationCenter.default.post(name: Notification.Name(rawValue: "showInterstitialKey"), object: nil)
        }
        let sequence = SKAction.sequence([wait, run])
        self.run(sequence)
    }
    
    func rateBtnPressed() {
        UIApplication.shared.openURL(URL(string: "itms-apps://itunes.apple.com/app/id1135303663")!)
    }
    
    func soundBtnPressed() {
        if soundOn == true {
            musicBtn.run(SKAction.setTexture(SKTexture(imageNamed: "MusicBtnOff")))
            soundOn = false
            // Sound is OFF
        } else {
            musicBtn.run(SKAction.setTexture(SKTexture(imageNamed: "MusicBtnOn")))
            soundOn = true
            // Sound is ON
        }
    }
}
