//
//  MainMenuScene.swift
//  Springy Cube
//
//  Created by Brian Lim on 7/8/16.
//  Copyright © 2016 codebluapps. All rights reserved.
//

import Foundation
import SpriteKit

class MainMenuScene: SKScene {
    
    var musicBtn = SKSpriteNode()
    var rateBtn = SKSpriteNode()
    var tutorialBtn = SKSpriteNode()
    var playBtn = SKSpriteNode()
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
    
    override func didMove(to view: SKView) {
        
        initalize()
        
        if soundOn == true {
            
            musicBtn.run(SKAction.setTexture(SKTexture(imageNamed: "MusicBtnOn")))
        } else {
            
            musicBtn.run(SKAction.setTexture(SKTexture(imageNamed: "MusicBtnOff")))
        }
    }
    
    func initalize() {
        
        createPlayBtn()
        createTitleLbl()
        createRedLevel()
        createBlueLevel()
        createGreenLevel()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            
            let location = touch.location(in: self)
            
            if atPoint(location) == rateBtn {
                
                rateBtn.texture = SKTexture(imageNamed: "RateBtnDown")
            }
            
            if atPoint(location) == tutorialBtn {
                
                tutorialBtn.texture = SKTexture(imageNamed: "TutorialBtnDown")
            }
            
            if atPoint(location) == playBtn {
                
                playBtn.texture = SKTexture(imageNamed: "PlayBtnDown")
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
            
            if atPoint(location) == tutorialBtn {
                
                tutorialBtn.texture = SKTexture(imageNamed: "TutorialBtn")
                
                createTutorialAlertView()
            }
            
            if atPoint(location) == playBtn {
                
                playBtn.texture = SKTexture(imageNamed: "PlayBtn")
                
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
            
            if atPoint(location) == tutorialBtn {
                
                tutorialBtn.texture = SKTexture(imageNamed: "TutorialBtn")
            }
            
            if atPoint(location) == playBtn {
                
                playBtn.texture = SKTexture(imageNamed: "PlayBtn")
                
            }
        }
    }
    
    func createPlayBtn() {
        
        playBtn = SKSpriteNode(imageNamed: "PlayBtn")
        playBtn.name = "PlayBtn"
        playBtn.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        playBtn.zPosition = 1
        playBtn.size = CGSize(width: 200, height: 200)
        playBtn.position = CGPoint(x: 0, y: -650)
        
        self.addChild(playBtn)
        
    }
    
    func createTitleLbl() {
        
        titleLbl = SKLabelNode(fontNamed: "PhosphateInline") // Future-CondensedMedium
        titleLbl.name = "TitleLbl"
        titleLbl.zPosition = 1
        titleLbl.fontColor = SKColor.darkGray
        titleLbl.fontSize = 150
        titleLbl.text = "SPRINGY CUBE"
        titleLbl.position = CGPoint(x: 0, y: playBtn.position.y + 170)
        
        self.addChild(titleLbl)
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
        
        tutorialBtn = SKSpriteNode(imageNamed: "TutorialBtn")
        tutorialBtn.name = "TutorialBtn"
        tutorialBtn.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        tutorialBtn.size = CGSize(width: 160, height: 160)
        tutorialBtn.position = CGPoint(x: leftRed.position.x + 450, y: leftRed.position.y)
        
        redLevel.zPosition = 1
        redLevel.position = CGPoint(x: 0, y: titleLbl.position.y + 250)
        
        redLevel.addChild(leftRed)
        redLevel.addChild(rightRed)
        redLevel.addChild(tutorialBtn)
        
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
        blueLevel.position = CGPoint(x: 0, y: titleLbl.position.y + 700)
        
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
        greenLevel.position = CGPoint(x: 0, y: titleLbl.position.y + 1150)
        
        greenLevel.addChild(leftGreen)
        greenLevel.addChild(rightGreen)
        greenLevel.addChild(musicBtn)
        
        self.addChild(greenLevel)
        
        let moveLeft = SKAction.moveTo(x: -100, duration: 1.2)
        let moveRight = SKAction.moveTo(x: 100, duration: 1.2)
        
        greenLevel.run(SKAction.repeatForever(SKAction.sequence([moveRight, moveLeft])))
    }
    
    func createTutorialAlertView() {
        let alert = UIAlertController(title: "How-To-Play", message: "Make your way up past the obstacles without hitting one, if an obstacle is hit...it is GAMEOVER!", preferredStyle: UIAlertControllerStyle.alert)
        let okay = UIAlertAction(title: "Let's Play", style: UIAlertActionStyle.default, handler: nil)
        
        alert.addAction(okay)
        
        self.view?.window?.rootViewController?.present(alert, animated: true, completion: nil)
        
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
