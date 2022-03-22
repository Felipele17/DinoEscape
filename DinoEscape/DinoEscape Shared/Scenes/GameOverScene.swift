//
//  GameOverScene.swift
//  DinoEscape
//
//  Created by Raphael Alkamim on 22/03/22.
//

import Foundation
import SpriteKit

class GameOverScene: MyScene {
    
    var highScore: Int = 140
    var score: Int = 100
    
    var playAgain = SKButton()
    var menu = SKButton()
    
    class func newGameScene() -> GameOverScene {
        let scene = GameOverScene()
        scene.scaleMode = .resizeFill
        return scene
    }
#if os( tvOS )
    override func didMove(to view: SKView) {
        self.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapped(sender:)))
        
        view.addGestureRecognizer(tap)
    }
#endif
    
    func setUpScene() {
        self.isUserInteractionEnabled = true
        
        backgroundColor = SKColor(red: 221/255, green: 108/255, blue: 50/255, alpha: 1)
        
#if os( tvOS )
        addTapGestureRecognizer()
#endif
        
        removeAllChildren()
        removeAllActions()
        
        let gameOverImage: SKSpriteNode = SKSpriteNode(imageNamed: "TRexGameOver")
        
        gameOverImage.position = CGPoint(x: size.width/2, y: size.height/5)
        gameOverImage.size = CGSize(width:  size.width, height: size.height/3)
        gameOverImage.zPosition = -5
        addChild(gameOverImage)
        
        let title: SKLabelNode = SKLabelNode(text: "G A M E   O V E R")
        title.fontName = "Aldrich-Regular"
        title.fontSize = 35
        title.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        title.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        title.numberOfLines = 2
        title.fontColor = SKColor(red: 235/255, green: 231/255, blue: 198/255, alpha: 1)
        title.position = CGPoint(x: size.width/2, y: size.height/1.12)
        addChild(title)
        
        createScore(name: .highScore, score: score, posX: 0, posY: 0)
        createScore(name: .score, score: score, posX: 0, posY: 1)
        
        
        playAgain = createButton(name: .menu, posX: 0,posY: 0)
        addChild(playAgain)
        menu = createButton(name: .playAgain, posX: 0, posY: 1)
        addChild(menu)
    }
    
    
    func createScore(name: ScoreTypes, score: Int, posX: Int, posY: Int) {
        let name: SKLabelNode = SKLabelNode(text: "\(name.rawValue)")
        name.fontName = "Aldrich-Regular"
        name.fontSize = 25
        name.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        name.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        name.numberOfLines = 2
        name.fontColor = SKColor(red: 235/255, green: 231/255, blue: 198/255, alpha: 1)
        name.position = CGPoint(x: frame.width / 2 ,
                                y: frame.height * 0.4 + CGFloat(posY) * frame.height * 0.2)
        
        
        
        let score: SKLabelNode = SKLabelNode(text: String(score))
        score.fontName = "Aldrich-Regular"
        score.fontSize = 25
        score.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        score.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        score.numberOfLines = 2
        score.fontColor = SKColor(red: 235/255, green: 231/255, blue: 198/255, alpha: 1)
        score.position = CGPoint(x: name.frame.width / 2,
                                 y: name.frame.height * 1 + CGFloat(posY) * name.frame.height / 1)
        
        addChild(name)
        addChild(score)
    }
    
    func createButton(name: GameOverButtonTypes, posX: Int, posY: Int) -> SKButton {
        let texture: SKTexture = SKTexture(imageNamed: "\(name.rawValue)")
        texture.filteringMode = .nearest
        
        let w: CGFloat = size.width / 3
        let h = w * texture.size().height / texture.size().width
        
        let button: SKButton = SKButton(texture: texture, color: .clear, size: CGSize(width: w, height: h))
        
        
        button.position = CGPoint(x: button.frame.width * 1.5 + CGFloat(posX) * button.frame.width / 1,
                                  y: button.frame.height * 9 + CGFloat(posY) * button.frame.height / 0.8)
        
        
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
    
#if os( tvOS )
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
        else if (menu.isFocused){
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
