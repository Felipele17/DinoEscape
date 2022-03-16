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
        
        backgroundColor = SKColor(red: 57/255, green: 100/255, blue: 113/255, alpha: 1)
        
        removeAllChildren()
        removeAllActions()
        
        createLabel(text: "Settings",
                    fontSize: 40,
                    fontColor: SKColor(red: 235/255, green: 231/255, blue: 198/255, alpha: 1),
                    position: CGPoint(x: size.width/2, y: size.height/1.30)
        )
        
        createLabel(text: "Sound effects",
                    fontSize: 25,
                    fontColor: SKColor(red: 1, green: 1, blue: 1, alpha: 1),
                    position: CGPoint(x: size.width/2.7, y: size.height/1.5)
        )
        
        createLabel(text: "Sound effects",
                    fontSize: 25,
                    fontColor: SKColor(red: 1, green: 1, blue: 1, alpha: 1),
                    position: CGPoint(x: size.width/2.7, y: size.height/1.5)
        )
        

        createLabel(text: "Music",
                    fontSize: 25,
                    fontColor: SKColor(red: 1, green: 1, blue: 1, alpha: 1),
                    position: CGPoint(x: size.width/2.7, y: size.height/1.7)
        )
    
        createLabel(text: "Vibration",
                    fontSize: 25,
                    fontColor: SKColor(red: 1, green: 1, blue: 1, alpha: 1),
                    position: CGPoint(x: size.width/2.7, y: size.height/1.96)
        )
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


