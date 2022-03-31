//
//  GameOverScene.swift
//  DinoEscape
//
//  Created by Raphael Alkamim on 22/03/22.
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
    
#if os(tvOS)
    override func didMove(to view: SKView) {
        self.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapped(sender:)))
        
        view.addGestureRecognizer(tap)
    }
#endif
    
    func setUpScene() {
        self.isUserInteractionEnabled = true
        
        backgroundColor = SKColor(red: 221/255, green: 108/255, blue: 50/255, alpha: 1)
        
#if os(tvOS)
        addTapGestureRecognizer()
#endif
        
        removeAllChildren()
        removeAllActions()
        
        let gameOverImage: SKSpriteNode = SKSpriteNode(imageNamed: "TRexGameOver")
        gameOverImage.zPosition = -5
        
#if os(iOS)
        gameOverImage.position = CGPoint(x: size.width/2, y: size.height/5)
        gameOverImage.size = CGSize(width:  size.width/1.33, height: size.height/4)
        
#elseif os(macOS) || os(tvOS)
        gameOverImage.position = CGPoint(x: size.width/2, y: size.height/5)
        gameOverImage.size = CGSize(width: size.width/3, height: size.height/3)
        
#endif
        
        addChild(gameOverImage)
        
        let title: SKLabelNode = SKLabelNode(text: "G A M E   O V E R".localized())
        title.fontName = "Aldrich-Regular"
        #if os(iOS)
        title.fontSize = 32
        #elseif os(macOS) || os(tvOS)
        title.fontSize = 85
        #endif
        title.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        title.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        title.numberOfLines = 2
        title.fontColor = SKColor(red: 235/255, green: 231/255, blue: 198/255, alpha: 1)
        title.position = CGPoint(x: size.width/2, y: size.height/1.13)
        addChild(title)
        
        createHighScore(name: .highScore, score: highScore, posY: 0)
        createScore(score: score)
        
        
        playAgain = createButton(name: .playAgain, posY: 1)
        addChild(playAgain)
        menuDino = createButton(name: .menu, posY: 0)
        addChild(menuDino)
    }
    
    
    func createHighScore(name: ScoreTypes, score: Int, posY: Int) {
        let name: SKLabelNode = SKLabelNode(text: "\(name.rawValue)")
        name.fontName = "Aldrich-Regular"
        #if os(iOS)
        name.fontSize = 30
        #elseif os(tvOS)
        name.fontSize = 45
        #elseif os(macOS)
        name.fontSize = 40
        #endif
        name.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        name.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        name.numberOfLines = 2
        name.fontColor = SKColor(red: 235/255, green: 231/255, blue: 198/255, alpha: 1)
        
        #if os(iOS)
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            name.position = CGPoint(x: frame.width / 2 ,
                                    y: frame.height / 1.44 + CGFloat(posY) *  frame.height * 0.20)
        case .phone:
            name.position = CGPoint(x: frame.width / 2 ,
                                    y: frame.height / 1.40 + CGFloat(posY) *  frame.height * 0.12)
        default:
            print("default")
        }
        
        #elseif os(macOS) || os(tvOS)
        name.position = CGPoint(x: frame.width / 2 ,
                                y: frame.height / 1.43 + CGFloat(posY) *  frame.height * 0.12)
        
        #endif
        
        let score: SKLabelNode = SKLabelNode(text: String(score))
        score.fontName = "Aldrich-Regular"
        #if os(iOS)
        score.fontSize = 45
        score.position = CGPoint(x: frame.width / 2,
                                 y: frame.height / 1.52 + CGFloat(posY) * frame.height  * 0.1)
        
        #elseif os(tvOS)
        score.fontSize = 45
        score.position = CGPoint(x: frame.width / 2,
                                 y: frame.height / 1.53 + CGFloat(posY) * frame.height  * 0.1)
        
        #elseif os(macOS)
        score.fontSize = 40
        score.position = CGPoint(x: frame.width / 2,
                                 y: frame.height / 1.53 + CGFloat(posY) * frame.height  * 0.1)
        
        #endif
        score.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        score.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        score.numberOfLines = 2
        score.fontColor = SKColor(red: 235/255, green: 231/255, blue: 198/255, alpha: 1)
        
        
       
        addChild(name)
        addChild(score)
    }
    
    func createScore(score: Int) {
        
        let score: SKLabelNode = SKLabelNode(text: String(score))
        score.fontName = "Aldrich-Regular"
        score.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        score.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        score.numberOfLines = 2
        score.fontColor = SKColor(red: 57/255, green: 100/255, blue: 113/255, alpha: 1)
        #if os(iOS)
        score.fontSize = 90
        score.position = CGPoint(x: frame.width / 2,
                                 y: frame.height / 1.26)
        #elseif os(macOS) || os(tvOS)
        score.fontSize = 90
        score.position = CGPoint(x: frame.width / 2,
                                 y: frame.height / 1.27)

        #endif
        
        addChild(score)
    }
    
    
    func createButton(name: GameOverButtonTypes, posY: Int) -> SKButton {
        let texture: SKTexture = SKTexture(imageNamed: "\(name.rawValue)")
        texture.filteringMode = .nearest
        
        var w : CGFloat
        var h : CGFloat
        
#if os(macOS) || os(tvOS)
        if name == .playAgain {
            w = size.width / 6
            h = w * texture.size().height / texture.size().width
        } else {
            w = size.width / 7.5
            h = w * texture.size().height / texture.size().width
        }
#else
        if name == .playAgain {
            w = size.width / 3.0
            h = w * texture.size().height / texture.size().width
        } else {
            w = size.width / 3.5
            h = w * texture.size().height / texture.size().width
        }
#endif
        
        #if os(iOS)
        if name == .playAgain {
            w = size.width / 2.5
            h = w * texture.size().height / texture.size().width
        } else {
            w = size.width / 3.0
            h = w * texture.size().height / texture.size().width
        }
        #endif
        
        
        
        let button: SKButton = SKButton(texture: texture, color: .clear, size: CGSize(width: w, height: h))
        
        button.position = CGPoint(x: frame.width / 2,
                                  y: frame.height / 2.25  + CGFloat(posY) * button.frame.height * 1.2)
        #if os(iOS)
        
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            button.position = CGPoint(x: frame.width / 2,
                                      y: frame.height / 2  + CGFloat(posY) * button.frame.height * 1.2)
            
        case .pad:
            button.position = CGPoint(x: frame.width / 2,
                                      y: frame.height / 2.25  + CGFloat(posY) * button.frame.height * 1.2)
        default:
            "Não há posição para o botão"
        }
        
       
        #endif

        
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
    
#if os(tvOS)
    func addTapGestureRecognizer() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.tapped(sender:)))
        self.scene?.view?.addGestureRecognizer(tapRecognizer)
        
    }
    
    
    
    @objc func tapped(sender: AnyObject) {
        
        if (playAgain.isFocused){
            let scene = GameScene.newGameScene()
            self.view?.presentScene(scene)
            scene.run(SKAction.wait(forDuration: 0.02))
            scene.view?.window?.rootViewController?.setNeedsFocusUpdate()
            scene.view?.window?.rootViewController?.updateFocusIfNeeded()
        }
        else if (menuDino.isFocused){
            let scene = HomeScene.newGameScene()
            self.view?.presentScene(scene)
            scene.run(SKAction.wait(forDuration: 0.02))
            scene.view?.window?.rootViewController?.setNeedsFocusUpdate()
            scene.view?.window?.rootViewController?.updateFocusIfNeeded()
        }
        else {
            print("não sei ler oq vc quer")
        }
    }
#endif
    
}
#if os( tvOS )
extension HomeScene {
    override var preferredFocusEnvironments: [UIFocusEnvironment]{
        return [btn]
    }
}
#endif
