//
//  GameplayScene.swift
//  Springy Cube
//
//  Created by Brian Lim on 7/8/16.
//  Copyright © 2016 codebluapps. All rights reserved.
//

import Foundation
import SpriteKit

class GameplayScene: SKScene, SKPhysicsContactDelegate {
    
    var player = SKSpriteNode()
    var scoreLbl = SKLabelNode()
    var tapToPlayLbl = SKLabelNode()
    
    var leftGreen = SKSpriteNode()
    var leftOrange = SKSpriteNode()
    var leftBlue = SKSpriteNode()
    var leftRed = SKSpriteNode()
    
    var rightGreen = SKSpriteNode()
    var rightOrange = SKSpriteNode()
    var rightBlue = SKSpriteNode()
    var rightRed = SKSpriteNode()
    
    var redLevel = SKNode()
    var blueLevel = SKNode()
    var orangeLevel = SKNode()
    var greenLevel = SKNode()
    
    var redScoreNode = SKSpriteNode()
    var blueScoreNode = SKSpriteNode()
    var orangeScoreNode = SKSpriteNode()
    var greenScoreNode = SKSpriteNode()
    
    var barrier = SKSpriteNode()
    
    let cam = SKCameraNode()
    
    var isAlive = true
    var redScoreNodeTouched = false
    var blueScoreNodeTouched = false
    var orangeScoreNodeTouched = false
    var greenScoreNodeTouched = false
    
    var difficultyIncreased1 = false
    var difficultyIncreased2 = false
    var difficultyIncreased3 = false
    var difficultyIncreased4 = false
    var difficultyIncreased5 = false
    var difficultyIncreased6 = false
    var difficultyIncreased7 = false
    var difficultyIncreased8 = false
    
    var movingDuration = 0.8
    var movingLengthNeg: CGFloat = -180.0
    var movingLengthPos: CGFloat = 180.0
    
    var counter = 0
    
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        
        self.camera = cam
        
        isAlive = true
        initialize()
    }
    
    func initialize() {
        
        createPlayer()
        createBarrier()
        createRedLevel()
        createBlueLevel()
        createOrangeLevel()
        createGreenLevel()
        createScoreLbl()
        createTapToPlayLbl()
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        checkRedLevelLocation()
        checkBlueLevelLocation()
        checkOrangeLevelLocation()
        checkGreenLevelLocation()
        
        cam.position = player.position
        scoreLbl.position.y = player.position.y + 650
        scoreLbl.position.x = player.position.x
        
        if counter >= 20 && difficultyIncreased1 == false {
            
            movingDuration = Double(GameManager.instance.randomBetweenNumbers(0.3, secondNum: 0.6))
            difficultyIncreased1 = true
            
            leftRed.position.x = -500
            rightRed.position.x = 500
            leftBlue.position.x = -500
            rightBlue.position.x = 500
            leftOrange.position.x = -500
            rightOrange.position.x = 500
            leftGreen.position.x = -500
            rightGreen.position.x = 500
        }
        
        if counter >= 20 && difficultyIncreased2 == false {
            
            movingDuration = Double(GameManager.instance.randomBetweenNumbers(0.3, secondNum: 0.6))
            difficultyIncreased2 = true
        }
        
        if counter >= 30 && difficultyIncreased3 == false {
            
            movingDuration = Double(GameManager.instance.randomBetweenNumbers(0.3, secondNum: 0.6))
            difficultyIncreased3 = true
            
        }
        
        if counter >= 40 && difficultyIncreased4 == false {
            
            movingDuration = Double(GameManager.instance.randomBetweenNumbers(0.2, secondNum: 0.4))
            difficultyIncreased4 = true
            
            leftRed.position.x = -480
            rightRed.position.x = 480
            leftBlue.position.x = -480
            rightBlue.position.x = 480
            leftOrange.position.x = -480
            rightOrange.position.x = 480
            leftGreen.position.x = -480
            rightGreen.position.x = 480
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if isAlive == true {
            
            jump()
            
            barrier.position.y = player.position.y - 500
            
        }
        
        tapToPlayLbl.removeFromParent()
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        var firstBody = SKPhysicsBody()
        var secondBody = SKPhysicsBody()
        
        if contact.bodyA.node?.name == "Player" {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        if firstBody.node?.name == "Player" && secondBody.node?.name == "RedScoreNode" {
            
            if redScoreNodeTouched == false {
                
                playPointEarnedSound()
                counter += 1
                scoreLbl.text = "\(counter)"
                redScoreNodeTouched = true
                
            }
            
        }
        
        if firstBody.node?.name == "Player" && secondBody.node?.name == "BlueScoreNode" {
            
            if blueScoreNodeTouched == false {
                
                playPointEarnedSound()
                counter += 1
                scoreLbl.text = "\(counter)"
                blueScoreNodeTouched = true
            }

        }
        
        if firstBody.node?.name == "Player" && secondBody.node?.name == "OrangeScoreNode" {
            
            if orangeScoreNodeTouched == false {
                
                playPointEarnedSound()
                counter += 1
                scoreLbl.text = "\(counter)"
                orangeScoreNodeTouched = true
                
            }

        }
        
        if firstBody.node?.name == "Player" && secondBody.node?.name == "GreenScoreNode" {
            
            if greenScoreNodeTouched == false {
                
                playPointEarnedSound()
                counter += 1
                scoreLbl.text = "\(counter)"
                greenScoreNodeTouched = true
            }
            
            

        }
        
        if firstBody.node?.name == "Player" && secondBody.node?.name == "leftRed" || secondBody.node?.name == "rightRed" {
            
            // End Game
            endGame()
        }
        
        if firstBody.node?.name == "Player" && secondBody.node?.name == "leftBlue" || secondBody.node?.name == "rightBlue" {
            
            // End Game
            endGame()
        }
        
        if firstBody.node?.name == "Player" && secondBody.node?.name == "leftOrange" || secondBody.node?.name == "rightOrange" {
            
            // End Game
            endGame()
        }
        
        if firstBody.node?.name == "Player" && secondBody.node?.name == "leftGreen" || secondBody.node?.name == "rightGreen" {
            
            // End Game
            endGame()
        }

    }
    
    func createPlayer() {
        
        player = SKSpriteNode(imageNamed: "Player")
        player.name = "Player"
        player.size = CGSize(width: 120, height: 120)
        player.zPosition = 2
        player.position = CGPoint(x: 0, y: -490)
        player.physicsBody = SKPhysicsBody(rectangleOf: player.size)
        player.physicsBody?.allowsRotation = false
        player.physicsBody?.affectedByGravity = true
        player.physicsBody?.categoryBitMask = ColliderType.Player
        player.physicsBody?.collisionBitMask = ColliderType.Barrier
        player.physicsBody?.contactTestBitMask = ColliderType.ScoreDetector | ColliderType.Obstacle
        
        self.addChild(player)
    }
    
    func jump() {
        
        playJumpSound()
        
        player.physicsBody?.velocity = CGVector(dx: 0, dy: -70)
        player.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 500))
    }
    
    
    func createScoreLbl() {
        
        scoreLbl = SKLabelNode(fontNamed: "PhosphateInLine")
        scoreLbl.name = "ScoreLbl"
        scoreLbl.fontSize = 170
        scoreLbl.text = "0"
        scoreLbl.fontColor = SKColor.darkGray
        scoreLbl.zPosition = 3
        scoreLbl.position = CGPoint(x: player.position.x, y: player.position.y + 650)
        
        self.addChild(scoreLbl)
    }
    
    func createTapToPlayLbl() {
        
        tapToPlayLbl = SKLabelNode(fontNamed: "PhosphateInLine")
        tapToPlayLbl.name = "TapToPlayLbl"
        tapToPlayLbl.fontSize = 120
        tapToPlayLbl.fontColor = SKColor.darkGray
        tapToPlayLbl.text = "TAP TO PLAY"
        tapToPlayLbl.zPosition = 3
        tapToPlayLbl.position = CGPoint(x: player.position.x, y: player.position.y - 400)
        
        let fadeOut = SKAction.fadeOut(withDuration: 0.4)
        let fadeIn = SKAction.fadeIn(withDuration: 0.4)
        
        tapToPlayLbl.run(SKAction.repeatForever(SKAction.sequence([fadeOut, fadeIn])))
        
        self.addChild(tapToPlayLbl)
    }
    
    func createBarrier() {
        
        barrier = SKSpriteNode(color: UIColor.clear, size: CGSize(width: (self.scene?.size.width)!, height: 10))
        barrier.name = "Barrier"
        barrier.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        barrier.zPosition = 2
        barrier.position = CGPoint(x: 0, y: -500)
        barrier.physicsBody = SKPhysicsBody(rectangleOf: barrier.size)
        barrier.physicsBody?.affectedByGravity = false
        barrier.physicsBody?.categoryBitMask = ColliderType.Barrier
        barrier.physicsBody?.isDynamic = false
        
        self.addChild(barrier)
    }
    
    func createRedLevel() {
        
        redLevel = SKNode()
        redLevel.name = "RedLevel"
        
        leftRed = SKSpriteNode(color: UIColor(red: 255.0 / 255.0, green: 87.0 / 255.0, blue: 87.0 / 255.0, alpha: 1.0), size: CGSize(width: 600, height: 80))
        leftRed.name = "leftRed"
        leftRed.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        leftRed.position = CGPoint(x: -520, y: 0)
        leftRed.physicsBody = SKPhysicsBody(rectangleOf: leftRed.size)
        leftRed.physicsBody?.affectedByGravity = false
        leftRed.physicsBody?.categoryBitMask = ColliderType.Obstacle
        leftRed.physicsBody?.isDynamic = false
        
        rightRed = SKSpriteNode(color: UIColor(red: 255.0 / 255.0, green: 87.0 / 255.0, blue: 87.0 / 255.0, alpha: 1.0), size: CGSize(width: 600, height: 80))
        rightRed.name = "rightRed"
        rightRed.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        rightRed.position = CGPoint(x: 520, y: 0)
        rightRed.physicsBody = SKPhysicsBody(rectangleOf: rightRed.size)
        rightRed.physicsBody?.affectedByGravity = false
        rightRed.physicsBody?.categoryBitMask = ColliderType.Obstacle
        rightRed.physicsBody?.isDynamic = false
        
        redScoreNode = SKSpriteNode(color: UIColor.clear, size: CGSize(width: 250, height: 2))
        redScoreNode.name = "RedScoreNode"
        redScoreNode.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        redScoreNode.position = CGPoint(x: 0, y: 0)
        redScoreNode.physicsBody = SKPhysicsBody(rectangleOf: redScoreNode.size)
        redScoreNode.physicsBody?.categoryBitMask = ColliderType.ScoreDetector
        redScoreNode.physicsBody?.contactTestBitMask = ColliderType.Player
        redScoreNode.physicsBody?.affectedByGravity = false
        redScoreNode.physicsBody?.isDynamic = false
        
        redLevel.zPosition = 1
        redLevel.position = CGPoint(x: 0, y: 100)
        
        redLevel.addChild(leftRed)
        redLevel.addChild(rightRed)
        redLevel.addChild(redScoreNode)
        
        self.addChild(redLevel)
        
        
        let moveLeft = SKAction.moveTo(x: movingLengthNeg, duration: movingDuration)
        let moveRight = SKAction.moveTo(x: movingLengthPos, duration: movingDuration)
        
        redLevel.run(SKAction.repeatForever(SKAction.sequence([moveRight, moveLeft])))
        
    }
    
    func createBlueLevel() {
        
        blueLevel = SKNode()
        blueLevel.name = "BlueLevel"
        
        leftBlue = SKSpriteNode(color: UIColor(red: 9.0 / 255.0, green: 194.0 / 255.0, blue: 255.0 / 255.0, alpha: 1.0), size: CGSize(width: 600, height: 80))
        leftBlue.name = "leftBlue"
        leftBlue.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        leftBlue.position = CGPoint(x: -520, y: 0)
        leftBlue.physicsBody = SKPhysicsBody(rectangleOf: leftBlue.size)
        leftBlue.physicsBody?.affectedByGravity = false
        leftBlue.physicsBody?.categoryBitMask = ColliderType.Obstacle
        leftBlue.physicsBody?.isDynamic = false
        
        rightBlue = SKSpriteNode(color: UIColor(red: 9.0 / 255.0, green: 194.0 / 255.0, blue: 255.0 / 255.0, alpha: 1.0), size: CGSize(width: 600, height: 80))
        rightBlue.name = "rightBlue"
        rightBlue.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        rightBlue.position = CGPoint(x: 520, y: 0)
        rightBlue.physicsBody = SKPhysicsBody(rectangleOf: rightBlue.size)
        rightBlue.physicsBody?.affectedByGravity = false
        rightBlue.physicsBody?.categoryBitMask = ColliderType.Obstacle
        rightBlue.physicsBody?.isDynamic = false
        
        blueScoreNode = SKSpriteNode(color: UIColor.clear, size: CGSize(width: 250, height: 2))
        blueScoreNode.name = "BlueScoreNode"
        blueScoreNode.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        blueScoreNode.position = CGPoint(x: 0, y: 0)
        blueScoreNode.physicsBody = SKPhysicsBody(rectangleOf: blueScoreNode.size)
        blueScoreNode.physicsBody?.categoryBitMask = ColliderType.ScoreDetector
        blueScoreNode.physicsBody?.contactTestBitMask = ColliderType.Player
        blueScoreNode.physicsBody?.affectedByGravity = false
        blueScoreNode.physicsBody?.isDynamic = false
        
        blueLevel.zPosition = 1
        blueLevel.position = CGPoint(x: 0, y: redLevel.position.y + 550)
        
        blueLevel.addChild(leftBlue)
        blueLevel.addChild(rightBlue)
        blueLevel.addChild(blueScoreNode)
        
        self.addChild(blueLevel)
        
        let moveLeft = SKAction.moveTo(x: movingLengthNeg, duration: movingDuration)
        let moveRight = SKAction.moveTo(x: movingLengthPos, duration: movingDuration)
        
        blueLevel.run(SKAction.repeatForever(SKAction.sequence([moveLeft, moveRight])))
        
    }
    
    func createOrangeLevel() {
        
        orangeLevel = SKNode()
        orangeLevel.name = "OrangeLevel"
        
        leftOrange = SKSpriteNode(color: UIColor(red: 255.0 / 255.0, green: 172.0 / 255.0, blue: 37.0 / 255.0, alpha: 1.0), size: CGSize(width: 600, height: 80))
        leftOrange.name = "leftOrange"
        leftOrange.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        leftOrange.position = CGPoint(x: -520, y: 0)
        leftOrange.physicsBody = SKPhysicsBody(rectangleOf: leftOrange.size)
        leftOrange.physicsBody?.affectedByGravity = false
        leftOrange.physicsBody?.categoryBitMask = ColliderType.Obstacle
        leftOrange.physicsBody?.isDynamic = false
        
        rightOrange = SKSpriteNode(color: UIColor(red: 255.0 / 255.0, green: 172.0 / 255.0, blue: 37.0 / 255.0, alpha: 1.0), size: CGSize(width: 600, height: 80))
        rightOrange.name = "rightOrange"
        rightOrange.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        rightOrange.position = CGPoint(x: 520, y: 0)
        rightOrange.physicsBody = SKPhysicsBody(rectangleOf: rightOrange.size)
        rightOrange.physicsBody?.affectedByGravity = false
        rightOrange.physicsBody?.categoryBitMask = ColliderType.Obstacle
        rightOrange.physicsBody?.isDynamic = false
        
        orangeScoreNode = SKSpriteNode(color: UIColor.clear, size: CGSize(width: 250, height: 2))
        orangeScoreNode.name = "OrangeScoreNode"
        orangeScoreNode.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        orangeScoreNode.position = CGPoint(x: 0, y: 0)
        orangeScoreNode.physicsBody = SKPhysicsBody(rectangleOf: orangeScoreNode.size)
        orangeScoreNode.physicsBody?.categoryBitMask = ColliderType.ScoreDetector
        orangeScoreNode.physicsBody?.contactTestBitMask = ColliderType.Player
        orangeScoreNode.physicsBody?.affectedByGravity = false
        orangeScoreNode.physicsBody?.isDynamic = false
        
        orangeLevel.zPosition = 1
        orangeLevel.position = CGPoint(x: 0, y: blueLevel.position.y + 550)
        
        orangeLevel.addChild(leftOrange)
        orangeLevel.addChild(rightOrange)
        orangeLevel.addChild(orangeScoreNode)
        
        
        self.addChild(orangeLevel)
        
        let moveLeft = SKAction.moveTo(x: movingLengthNeg, duration: movingDuration)
        let moveRight = SKAction.moveTo(x: movingLengthPos, duration: movingDuration)
        
        orangeLevel.run(SKAction.repeatForever(SKAction.sequence([moveRight, moveLeft])))
    }
    
    func createGreenLevel() {
        
        greenLevel = SKNode()
        greenLevel.name = "GreenLevel"
        
        leftGreen = SKSpriteNode(color: UIColor(red: 126.0 / 255.0, green: 211.0 / 255.0, blue: 33.0 / 255.0, alpha: 1.0), size: CGSize(width: 600, height: 80))
        leftGreen.name = "leftGreen"
        leftGreen.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        leftGreen.position = CGPoint(x: -520, y: 0)
        leftGreen.physicsBody = SKPhysicsBody(rectangleOf: leftGreen.size)
        leftGreen.physicsBody?.affectedByGravity = false
        leftGreen.physicsBody?.categoryBitMask = ColliderType.Obstacle
        leftGreen.physicsBody?.isDynamic = false
        
        rightGreen = SKSpriteNode(color: UIColor(red: 126.0 / 255.0, green: 211.0 / 255.0, blue: 33.0 / 255.0, alpha: 1.0), size: CGSize(width: 600, height: 80))
        rightGreen.name = "rightGreen"
        rightGreen.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        rightGreen.position = CGPoint(x: 520, y: 0)
        rightGreen.physicsBody = SKPhysicsBody(rectangleOf: rightGreen.size)
        rightGreen.physicsBody?.affectedByGravity = false
        rightGreen.physicsBody?.collisionBitMask = ColliderType.Obstacle
        rightGreen.physicsBody?.isDynamic = false
        
        greenScoreNode = SKSpriteNode(color: UIColor.clear, size: CGSize(width: 250, height: 2))
        greenScoreNode.name = "GreenScoreNode"
        greenScoreNode.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        greenScoreNode.position = CGPoint(x: 0, y: 0)
        greenScoreNode.physicsBody = SKPhysicsBody(rectangleOf: greenScoreNode.size)
        greenScoreNode.physicsBody?.categoryBitMask = ColliderType.ScoreDetector
        greenScoreNode.physicsBody?.contactTestBitMask = ColliderType.Player
        greenScoreNode.physicsBody?.affectedByGravity = false
        greenScoreNode.physicsBody?.isDynamic = false
        
        greenLevel.zPosition = 1
        greenLevel.position = CGPoint(x: 0, y: orangeLevel.position.y + 550)
        
        greenLevel.addChild(leftGreen)
        greenLevel.addChild(rightGreen)
        greenLevel.addChild(greenScoreNode)
        
        self.addChild(greenLevel)
        
        let moveLeft = SKAction.moveTo(x: movingLengthNeg, duration: movingDuration)
        let moveRight = SKAction.moveTo(x: movingLengthPos, duration: movingDuration)
        
        greenLevel.run(SKAction.repeatForever(SKAction.sequence([moveLeft, moveRight])))
    }
    
    func checkRedLevelLocation() {
        
        self.enumerateChildNodes(withName: "RedLevel", using: ({
            (node, error) in
            
            if node.position.y < (self.cam.position.y - 800) {
            
                node.position.y = self.greenLevel.position.y + 550
                self.redScoreNodeTouched = false
            }
        
        }))
    }
    
    func checkBlueLevelLocation() {
        
        self.enumerateChildNodes(withName: "BlueLevel", using: ({
            (node, error) in
            
            if node.position.y < (self.cam.position.y - 800) {
                
                node.position.y = self.redLevel.position.y + 550
                self.blueScoreNodeTouched = false
            }
            
        }))
    }
    
    func checkOrangeLevelLocation() {
        
        self.enumerateChildNodes(withName: "OrangeLevel", using: ({
            (node, error) in
            
            if node.position.y < (self.cam.position.y - 800) {
                
                node.position.y = self.blueLevel.position.y + 550
                self.orangeScoreNodeTouched = false
            }
            
        }))
    }
    
    func checkGreenLevelLocation() {
        
        self.enumerateChildNodes(withName: "GreenLevel", using: ({
            (node, error) in
            
            if node.position.y < (self.cam.position.y - 800) {
                
                node.position.y = self.orangeLevel.position.y + 550
                self.greenScoreNodeTouched = false
            }
            
        }))
    }
    
    func endGame() {
        
        isAlive = false
        
        player.removeFromParent()
    
        UserDefaults.standard.set(counter, forKey: "SCORE")
        
        let wait = SKAction.wait(forDuration: 0.5)
        let run = SKAction.run {
            
            self.removeAllActions()
            self.removeAllChildren()
            let gameover = GameoverScene(fileNamed: "GameoverScene")
            gameover?.scaleMode = .aspectFill
            self.view?.presentScene(gameover!, transition: SKTransition.fade(withDuration: 0.5))
            
        }
        
        self.run(SKAction.sequence([wait, run]))
        
    }
    
    func playJumpSound() {
        
        let play = SKAction.playSoundFileNamed("Jump1.mp3", waitForCompletion: false)
        if soundOn == true {
            
            self.run(play)
        }
        
    }
    
    func playPointEarnedSound() {
        
        let play = SKAction.playSoundFileNamed("PointEarned1.mp3", waitForCompletion: false)
        if soundOn == true {
            
            self.run(play)
        }
        
    }
    
}
