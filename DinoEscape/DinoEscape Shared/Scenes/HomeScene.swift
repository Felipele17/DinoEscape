//
//  GameSceneIOS.swift
//  DinoEscape iOS
//
//  Created by Raphael Alkamim on 11/03/22.
//

import Foundation
import SpriteKit

class HomeScene: SKScene {
    
    
    class func newGameScene() -> HomeScene {
        let scene = HomeScene()
        scene.scaleMode = .resizeFill
        GameController.shared.setScene(scene: scene)
        return scene
    }
    
    func setUpScene() {
        self.isUserInteractionEnabled = true
        
        backgroundColor = SKColor(red: 57/255, green: 100/255, blue: 113/255, alpha: 1)
        
        removeAllChildren()
        removeAllActions()
        
        let backgroundImage: SKSpriteNode = SKSpriteNode(imageNamed: "homeBackground")
        
        backgroundImage.position = CGPoint(x: size.width/2, y: size.height/2)
        backgroundImage.size = frame.size
        backgroundImage.zPosition = -5
        addChild(backgroundImage)
        

        
        createButton(name: .play, pos: 0)
        createButton(name: .settings, pos: 1)
        createButton(name: .shop, pos: 2)
    }
    
    
    func createButton(name: ButtonType, pos: Int) {
        let texture: SKTexture = SKTexture(imageNamed: "\(name.rawValue)")
        texture.filteringMode = .nearest
        let title: SKLabelNode = SKLabelNode(text: "\(name.rawValue)")
        //title.fontName =
        title.fontSize = 22
        title.fontColor = .black
        
        
        let w: CGFloat = size.width / 4.8
        let h = w * texture.size().height / texture.size().width
        
        let button: SKButton = SKButton(texture: texture, color: .clear, size: CGSize(width: w, height: h))
        
        button.position = CGPoint(x: button.frame.width * 1.2 + CGFloat(pos) * button.frame.width * 1.2, y: size.height/4.8)
        title.position = CGPoint(x: button.frame.width * 1.2 + CGFloat(pos) * button.frame.width * 1.2, y: size.height/6.3)
       
        button.selectedHandler = {
            print(name)
        }
        addChild(button)
        addChild(title)
    }
    
    
    override func didChangeSize(_ oldSize: CGSize) {
        super.didChangeSize(oldSize)
        
        setUpScene()
    }
    
}

