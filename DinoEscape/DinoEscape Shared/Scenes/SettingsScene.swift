//
//  SettingsSceneIOS.swift
//  DinoEscape iOS
//
//  Created by Raphael Alkamim on 11/03/22.
//

import Foundation
import SpriteKit

class SettingsScene: SKScene {
    
    class func newGameScene() -> SettingsScene {
        let scene = SettingsScene()
        scene.scaleMode = .resizeFill
        GameController.shared.setScene(scene: scene)
        return scene
    }
    
    func setUpScene() {
        self.isUserInteractionEnabled = true
        
        removeAllChildren()
        removeAllActions()
        
        let backgroundImage: SKSpriteNode = SKSpriteNode(imageNamed: "homeBackground-iOS")
        
        backgroundImage.position = CGPoint(x: size.width/2, y: size.height/2)
        backgroundImage.size = frame.size
        backgroundImage.zPosition = -5
        addChild(backgroundImage)
        
        
        createLabel(text: "Settings",
                    fontSize: 30,
                    fontColor: SKColor(red: 57/255, green: 100/255, blue: 113/255, alpha: 1),
                    position: CGPoint(x: size.width/2, y: size.height/1.35)
        )
        
        createLabel(text: "Sound effects",
                    fontSize: 23,
                    fontColor: SKColor(red: 57/255, green: 100/255, blue: 113/255, alpha: 1),
                    position: CGPoint(x: size.width/2.5, y: size.height/1.55)
        )
        
        
        createLabel(text: "Music",
                    fontSize: 23,
                    fontColor: SKColor(red: 57/255, green: 100/255, blue: 113/255, alpha: 1),
                    position: CGPoint(x: size.width/2.5, y: size.height/1.76)
        )
        
        createLabel(text: "Vibration",
                    fontSize: 23,
                    fontColor: SKColor(red: 57/255, green: 100/255, blue: 113/255, alpha: 1),
                    position: CGPoint(x: size.width/2.5, y: size.height/2.04)
        )
        
        createLabel(text: "Back",
                    fontSize: 23,
                    fontColor: SKColor(red: 1, green: 1, blue: 1, alpha: 1),
                    position: CGPoint(x: size.width/2, y: size.height/2.55)
        )
        
        //createButton(name: "Back", pos: CGPoint(x: size.width/2, y: size.height/2.55), titleColor: SKColor(red: 1, green: 1, blue: 1, alpha: 1))
        
    }
        
        func createLabel(text: String, fontSize: CGFloat, fontColor: SKColor, position: CGPoint) {
            let label: SKLabelNode = SKLabelNode(text: text)
            label.fontName = "Aldrich-Regular"
            label.fontSize = fontSize
            label.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
            label.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
            label.fontColor = fontColor
            label.position = position
            addChild(label)
        }

        
    override func didChangeSize(_ oldSize: CGSize) {
        super.didChangeSize(oldSize)
        
        setUpScene()
    }
    
}


