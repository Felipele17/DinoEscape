//
//  SettingsPopUp.swift
//  DinoEscape
//
//  Created by Raphael Alkamim on 21/03/22.
//

import Foundation
import SpriteKit

class SettingsPopUpScene: MyScene {
    
    class func newGameScene() -> SettingsPopUpScene {
        let scene = SettingsPopUpScene()
        scene.scaleMode = .resizeFill
        return scene
    }
    
    func setUpScene() {
        self.isUserInteractionEnabled = true
        
        removeAllChildren()
        removeAllActions()
        
        let background = SKShapeNode(rect: CGRect(x: size.width / 7,
                                                  y: size.height / 3.5,
                                                  width: size.width / 1.4,
                                                  height: size.height/2))
        
        background.fillColor = SKColor(red: 235/255, green: 231/255, blue: 198/255, alpha: 1)
        
        addChild(background)
        
        createLabel(text: "Settings",
                    fontSize: size.width/13,
                    fontColor: SKColor(red: 57/255, green: 100/255, blue: 113/255, alpha: 1),
                    position: CGPoint(x: size.width/2, y: size.height/1.45)
        )
        
        createLabel(text: "Music",
                    fontSize: size.width/20,
                    fontColor: SKColor(red: 57/255, green: 100/255, blue: 113/255, alpha: 1),
                    position: CGPoint(x: size.width/2.7, y: size.height/1.7)
        )
        
        createLabel(text: "Vibration",
                    fontSize: size.width/20,
                    fontColor: SKColor(red: 57/255, green: 100/255, blue: 113/255, alpha: 1),
                    position: CGPoint(x: size.width/2.7, y: size.height/2.07)
        )
        
        createSwitch(pos: CGPoint(x: size.width/1.45, y: size.height/1.7), name: "music")
        createSwitch(pos: CGPoint(x: size.width/1.45, y: size.height/2.05), name: "vibration")
        
        createBackButton()
        
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
            if name == "music" {
                self.changeSwitchImageState(switchButton: switchButton, state: &state)
                //ação de ligar e desligar som
            } else if name == "vibration" {
                self.changeSwitchImageState(switchButton: switchButton, state: &state)
                
                //ação de ligar e desligar vibração
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
    
    func createBackButton() {
        
        let texture = SKTexture(imageNamed: "buyButton")
        texture.filteringMode = .nearest
        
        
        let w: CGFloat = size.width / 3
        let h = w * texture.size().height / texture.size().width
        
        let button: SKButton = SKButton(texture: texture, color: .clear, size: CGSize(width: w, height: h))
        button.position = CGPoint(x: size.width / 2 , y: size.height/2.8)
        button.selectedHandler = {
            self.removeFromParent()
        
        }
        addChild(button)
        
   
    }
    
    override func didChangeSize(_ oldSize: CGSize) {
        super.didChangeSize(oldSize)
        
        setUpScene()
    }
    
}
