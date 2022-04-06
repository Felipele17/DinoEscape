//
//  GameOverScene.swift
//  DinoEscape iOS
//
//  Created by Carolina Ortega on 01/04/22.
//

import Foundation
import SpriteKit

class GameOverScene: MyScene {
    var highScore: Int = UserDefaults().integer(forKey: "HighScore")
    var score: Int = GameController.shared.gameData.score
    
    var playAgain = SKButton()
    var menuDino = SKButton()
    
    class func newGameScene() -> GameOverScene {
        let scene = GameOverScene()
        scene.scaleMode = .resizeFill
        return scene
    }
    
    func setUpScene() {
        self.isUserInteractionEnabled = true
        
        backgroundColor = SKColor(red: 221 / 255, green: 108 / 255, blue: 50 / 255, alpha: 1)
         
        removeAllChildren()
        removeAllActions()
        
        let gameOverImage: SKSpriteNode = SKSpriteNode(imageNamed: "TRexGameOver")
        gameOverImage.zPosition = -5
        gameOverImage.position = CGPoint(x: size.width / 2, y: size.height / 5)
        gameOverImage.size = CGSize(width: size.width / 1.33, height: size.height / 4)
        
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            gameOverImage.size = CGSize(width: size.width / 1.33, height: size.height / 4)
        case .pad:
            gameOverImage.size = CGSize(width: size.width / 1.8, height: size.height / 3.5)
        default:
            print("oi")
        }
        
        addChild(gameOverImage)
        
        let title: SKLabelNode = SKLabelNode(text: "G A M E   O V E R".localized())
        title.fontName = "Aldrich-Regular"
//        title.fontSize = 32
        
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            title.fontSize = 32
        case .pad:
            title.fontSize = 52
        default:
            print("oi")
        }
        
        title.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        title.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        title.numberOfLines = 2
        title.fontColor = SKColor(red: 235 / 255, green: 231 / 255, blue: 198 / 255, alpha: 1)
        title.position = CGPoint(x: size.width / 2, y: size.height / 1.13)
        addChild(title)
        
        createHighScore(name: .highScore, score: highScore, posY: 0)
        createScore(score: score)
    
        playAgain = createButton(name: .menu, posY: 0)
        addChild(playAgain)
        menuDino = createButton(name: .playAgain, posY: 1)
        addChild(menuDino)
    }
    
    func createHighScore(name: ScoreTypes, score: Int, posY: Int) {
        let name: SKLabelNode = SKLabelNode(text: "\(name.rawValue)")
        name.fontName = "Aldrich-Regular"
        name.fontSize = 30
        name.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        name.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        name.numberOfLines = 2
        name.fontColor = SKColor(red: 235 / 255, green: 231 / 255, blue: 198 / 255, alpha: 1)
        
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            name.position = CGPoint(x: frame.width / 2 ,
                                    y: frame.height / 1.42 + CGFloat(posY) * frame.height * 0.20)
        case .phone:
            name.position = CGPoint(x: frame.width / 2 ,
                                    y: frame.height / 1.40 + CGFloat(posY) * frame.height * 0.12)
        default:
            print("default")
        }
        
        let score: SKLabelNode = SKLabelNode(text: String(score))
        score.fontName = "Aldrich-Regular"
        score.fontSize = 45
        score.position = CGPoint(x: frame.width / 2,
                                 y: frame.height / 1.52 + CGFloat(posY) * frame.height * 0.1)
        
        score.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        score.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        score.numberOfLines = 2
        score.fontColor = SKColor(red: 235 / 255, green: 231 / 255, blue: 198 / 255, alpha: 1)
        
        addChild(name)
        addChild(score)
    }
    
    func createScore(score: Int) {
        let score: SKLabelNode = SKLabelNode(text: String(score))
        score.fontName = "Aldrich-Regular"
        score.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        score.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        score.numberOfLines = 2
        score.fontColor = SKColor(red: 57 / 255, green: 100 / 255, blue: 113 / 255, alpha: 1)
        score.fontSize = 90
        score.position = CGPoint(x: frame.width / 2,
                                 y: frame.height / 1.26)
        
        addChild(score)
    }
    
    func createButton(name: GameOverButtonTypes, posY: Int) -> SKButton {
        let texture: SKTexture = SKTexture(imageNamed: "\(name.rawValue)")
        texture.filteringMode = .nearest
        
        var width: CGFloat
        var height: CGFloat

        if name == .playAgain {
            width = size.width / 2.5
            height = width * texture.size().height / texture.size().width
        } else {
            width = size.width / 3.0
            height = width * texture.size().height / texture.size().width
        }
        
        let button: SKButton = SKButton(texture: texture, color: .clear, size: CGSize(width: width, height: height))

        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            button.position = CGPoint(x: frame.width / 2,
                                      y: frame.height / 2 + CGFloat(posY) * button.frame.height * 1.2)
        case .pad:
            button.position = CGPoint(x: frame.width / 2,
                                      y: frame.height / 2.25 + CGFloat(posY) * button.frame.height * 1.2)
        default:
            print("Não há posição para o botão")
        }
        
        button.selectedHandler = {
            switch name {
            case .playAgain:
                self.view?.presentScene(GameScene.newGameScene())
            case .menu:
                self.view?.presentScene(HomeScene.newGameScene())
            }
        }
        
        return button
        
    }

    override func didChangeSize(_ oldSize: CGSize) {
        super.didChangeSize(oldSize)
        
        setUpScene()
    }

}
