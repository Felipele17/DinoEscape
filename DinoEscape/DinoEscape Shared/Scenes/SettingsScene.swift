//
//  SettingsSceneIOS.swift
//  DinoEscape iOS
//
//  Created by Raphael Alkamim on 11/03/22.
//

import Foundation
import SpriteKit

class SettingsScene: MyScene {
    
    class func newGameScene() -> SettingsScene {
        let scene = SettingsScene()
        scene.scaleMode = .resizeFill
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
        
        let title: SKLabelNode = SKLabelNode(text: "D I N O")
        title.fontName = "Aldrich-Regular"
        title.fontSize = 40
        title.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        title.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        title.numberOfLines = 2
        title.fontColor = SKColor(red: 235/255, green: 231/255, blue: 198/255, alpha: 1)
        title.position = CGPoint(x: size.width/2, y: size.height/1.09)
        addChild(title)
        
        let subtitle: SKLabelNode = SKLabelNode(text: "E S C A P E")
        subtitle.fontName = "Aldrich-Regular"
        subtitle.fontSize = 40
        subtitle.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        subtitle.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        subtitle.numberOfLines = 2
        subtitle.fontColor = SKColor(red: 235/255, green: 231/255, blue: 198/255, alpha: 1)
        subtitle.position = CGPoint(x: size.width/2, y: size.height/1.164)
        addChild(subtitle)
        
        createLabel(text: "Settings",
                    fontSize: size.width/13,
                    fontColor: SKColor(red: 57/255, green: 100/255, blue: 113/255, alpha: 1),
                    position: CGPoint(x: size.width/2, y: size.height/1.45)
        )
        
        createLabel(text: "  Sound \n effects",
                    fontSize: size.width/20,
                    fontColor: SKColor(red: 57/255, green: 100/255, blue: 113/255, alpha: 1),
                    position: CGPoint(x: size.width/2.7, y: size.height/1.7)
        )
        
        createLabel(text: "Music",
                    fontSize: size.width/20,
                    fontColor: SKColor(red: 57/255, green: 100/255, blue: 113/255, alpha: 1),
                    position: CGPoint(x: size.width/2.7, y: size.height/2.07)
        )
        
        createLabel(text: "Vibration",
                    fontSize: size.width/20,
                    fontColor: SKColor(red: 57/255, green: 100/255, blue: 113/255, alpha: 1),
                    position: CGPoint(x: size.width/2.7, y: size.height/2.555)
        )
        createButton(name: .play, pos: 0, titleColor: SKColor(red: 255/255, green: 139/255, blue: 139/255, alpha: 1))
        createButton(name: .settings, pos: 1, titleColor: SKColor(red: 255/255, green: 229/255, blue: 139/255, alpha: 1))
        createButton(name: .shop, pos: 2, titleColor: SKColor(red: 139/255, green: 179/255, blue: 255/255, alpha: 1))
        
        createSwitch(pos: CGPoint(x: size.width/1.45, y: size.height/1.7), name: "sound")
        createSwitch(pos: CGPoint(x: size.width/1.45, y: size.height/2.05), name: "music")
        createSwitch(pos: CGPoint(x: size.width/1.45, y: size.height/2.535), name: "vibration")
        
       
        
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
            if name == .play {
                self.view?.presentScene(GameScene.newGameScene())
            } else if name == .shop {
                self.view?.presentScene(EggScene.newGameScene())
            } else if name == .settings {
                self.view?.presentScene(SettingsScene.newGameScene())
            } else {
                print("out of range")
            }
        }
        addChild(button)
        addChild(title)
    }
    
    func changeSwitchImageState(switchButton: SKButton, state: inout Bool){

        if state {
            switchButton.texture = SKTexture(imageNamed: "switchOFF")
        } else {
            switchButton.texture = SKTexture(imageNamed: "switchON")
        }
        state.toggle()
    }
    
    func createSwitch(pos: CGPoint, name: String) {
    
        var state: Bool = true

        let texture: SKTexture = SKTexture(imageNamed: "switchON")
        texture.filteringMode = .nearest
    
        let w: CGFloat = size.width / 6.0
        let h = w * texture.size().height / texture.size().width
        
        let switchButton: SKButton = SKButton(texture: texture, color: .clear, size: CGSize(width: w, height: h))
        switchButton.position = pos
       
        switchButton.selectedHandler = {
            if name == "sound" {
                self.changeSwitchImageState(switchButton: switchButton, state: &state)
                //ação de ligar e desligar som
            } else if name == "music" {
                self.changeSwitchImageState(switchButton: switchButton, state: &state)
            
                //ação de ligar e desligar musica
            } else {
                self.changeSwitchImageState(switchButton: switchButton, state: &state)
                
            }
        }
        addChild(switchButton)
    }
    
    
    func createLabel(text: String, fontSize: CGFloat, fontColor: SKColor, position: CGPoint) {
        let label: SKLabelNode = SKLabelNode(text: text)
        label.fontName = "Aldrich-Regular"
        label.fontSize = fontSize
        label.numberOfLines = 2
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


