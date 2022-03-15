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
        
        /*let title: SKLabelNode = SKLabelNode(text: "D I N O")
        title.fontName = "Aldrich-Regular"
        title.fontSize = 40
        title.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        title.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        title.numberOfLines = 2
        title.fontColor = SKColor(red: 235/255, green: 231/255, blue: 198/255, alpha: 1)
        title.position = CGPoint(x: size.width/2, y: size.height/1.09)
        addChild(title)
        */
    
    }
    
    
    func createButton(name: ButtonType, pos: Int, titleColor: SKColor) {
        let texture: SKTexture = SKTexture(imageNamed: "\(name.rawValue)")
        texture.filteringMode = .nearest
        let title: SKLabelNode = SKLabelNode(text: "\(name.rawValue)")
        title.fontName = "Aldrich-Regular"
        title.fontSize = 20
        title.fontColor = titleColor
        
        let w: CGFloat = size.width / 4.8
        let h = w * texture.size().height / texture.size().width
        
        let button: SKButton = SKButton(texture: texture, color: .clear, size: CGSize(width: w, height: h))
        
        button.position = CGPoint(x: button.frame.width * 1 + CGFloat(pos) * button.frame.width * 1.4, y: size.height/5.4)
        title.position = CGPoint(x: button.frame.width * 1 + CGFloat(pos) * button.frame.width * 1.4, y: size.height/7.8)
       
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


