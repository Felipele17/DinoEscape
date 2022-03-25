//
//  SettingsPopUp.swift
//  DinoEscape
//
//  Created by Raphael Alkamim on 21/03/22.
//

import Foundation
import SpriteKit

class SettingsPopUpScene: SKSpriteNode {
    
    var btn = SKButton()
    var btnHome = SKButton()


    
    override init(texture: SKTexture?, color: SKColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        self.isUserInteractionEnabled = true
        self.setUpScene()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.isUserInteractionEnabled = true
    }
    
    func setUpScene() {
        self.isUserInteractionEnabled = true
        
        removeAllChildren()
        removeAllActions()
        
        let background = SKShapeNode(rect: CGRect(x: self.size.width/2 * -1,
                                                  y: self.size.height/2 * -1,
                                                  width: self.size.width,
                                                  height: self.size.height))
        
        background.fillColor = SKColor(red: 235/255, green: 231/255, blue: 198/255, alpha: 1)
        print(background.position)
        self.addChild(background)
        
        background.addChild(createLabel(text: "Pause".localized(),
                                        fontSize: size.height/13,
                                        fontColor: SKColor(red: 57/255, green: 100/255, blue: 113/255, alpha: 1),
                                        position: CGPoint(x: 0, y: background.frame.size.height/3),
                                        alignmentH: SKLabelHorizontalAlignmentMode.center
                                       ))
        
        background.addChild(createLabel(text: "Music".localized(),
                                        fontSize: size.height/22,
                                        fontColor: SKColor(red: 57/255, green: 100/255, blue: 113/255, alpha: 1),
                                        position: CGPoint(x: background.frame.size.width/3 * -1, y: background.frame.size.height/8),
                                        alignmentH: SKLabelHorizontalAlignmentMode.left
                                       ))
        
        background.addChild(createLabel(text: "Vibration".localized(),
                                        fontSize: size.height/22,
                                        fontColor: SKColor(red: 57/255, green: 100/255, blue: 113/255, alpha: 1),
                                        position: CGPoint(x: background.frame.size.width/3 * -1, y: background.frame.size.height/8 * -1),
                                        alignmentH: SKLabelHorizontalAlignmentMode.left
                                       ))
        
        
        background.addChild(createSwitch(pos: CGPoint(x: background.frame.size.width/4, y: background.frame.size.height/8), name: "music"))
        
        background.addChild(createSwitch(pos: CGPoint(x: background.frame.size.width/4, y: background.frame.size.height/8 * -1), name: "vibration"))
        
        btn = createBackButton(position: CGPoint(x: 0, y: background.frame.size.height/3.5 * -1))
        btnHome = createHomeButton(position: CGPoint(x: 0, y: background.frame.size.height/2.5 * -1))
        
        background.addChild(btn)
        background.addChild(btnHome)
    }
    
    
    
    
    func changeSwitchImageState(switchButton: SKButton, state: inout Bool){
        
        if state {
            switchButton.texture = SKTexture(imageNamed: "switchOFF")
        } else {
            switchButton.texture = SKTexture(imageNamed: "switchON")
        }
        state.toggle()
    }
    
    func createSwitch(pos: CGPoint, name: String) -> SKButton {
        
        var state: Bool = true
        
        let texture: SKTexture = SKTexture(imageNamed: "switchON")
        texture.filteringMode = .nearest
        let w: CGFloat = size.width / 5.0
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
        return switchButton
    }
    
    
    
    func createLabel(text: String, fontSize: CGFloat, fontColor: SKColor, position: CGPoint, alignmentH: SKLabelHorizontalAlignmentMode) -> SKLabelNode {
        let label: SKLabelNode = SKLabelNode(text: text)
        label.fontName = "Aldrich-Regular"
        label.fontSize = fontSize
        label.numberOfLines = 2
        label.horizontalAlignmentMode = alignmentH
        label.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        label.fontColor = fontColor
        label.position = position
        return label
    }
    
    func createBackButton(position: CGPoint) -> SKButton{
        
        let texture = SKTexture(imageNamed: "resumeButton")
        texture.filteringMode = .nearest
        
        
        let w: CGFloat = size.height / 3
        let h = w * texture.size().height / texture.size().width
        
        let button: SKButton = SKButton(texture: texture, color: .clear, size: CGSize(width: w, height: h))
        button.position = position
        button.selectedHandler = {
            self.removeFromParent()
            GameController.shared.gameData.gameStatus = .playing
            GameController.shared.pauseActionItems()
        }
        return button
        
        
    }
    func createHomeButton(position: CGPoint) -> SKButton{
        
        let texture = SKTexture(imageNamed: "homeBackButton")
        texture.filteringMode = .nearest
        
        
        let w: CGFloat = size.height / 4
        let h = w * texture.size().height / texture.size().width
        
        let button: SKButton = SKButton(texture: texture, color: .clear, size: CGSize(width: w, height: h))
        button.position = position
        button.selectedHandler = {
            GameController.shared.restartGame()
            self.scene?.view?.presentScene(HomeScene.newGameScene())
        }
        return button
        
        
    }
#if os( tvOS )
    func addTapGestureRecognizer() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.tapped(sender:)))
        self.scene?.view?.addGestureRecognizer(tapRecognizer)
        
    }
    
    
    
    @objc func tapped(sender: AnyObject) {
        
        if (btn.isFocused){
            
            print("To focando no botão de volta")
//            let scene = GameScene.newGameScene()
//            self.presentScene(scene)
//            scene.run(SKAction.wait(forDuration: 0.02))
//            scene.view?.window?.rootViewController?.setNeedsFocusUpdate()
//            scene.view?.window?.rootViewController?.updateFocusIfNeeded()
           
        }
        else {
            print("não sei ler oq vc quer")
        }
    }
#endif
    
}
