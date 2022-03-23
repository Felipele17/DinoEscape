//
//  SettingsSceneIOS.swift
//  DinoEscape iOS
//
//  Created by Raphael Alkamim on 11/03/22.
//

import Foundation
import SpriteKit

class SettingsScene: MyScene {
    
    var state: Bool = true
    
    // buttons
    var btn = SKButton()
    var btn2 = SKButton()
    var btn3 = SKButton()
    
    // switches
    var switch2 = SKButton()
    var switch3 = SKButton()
    
    var toggleON: Bool = true
    
    let node = SKButton()
    
    class func newGameScene() -> SettingsScene {
        let scene = SettingsScene()
        scene.scaleMode = .resizeFill
        return scene
    }
    
    func setUpScene() {
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
        
#if os(macOS) || os(tvOS)
        title.setScale(1.5)
        subtitle.setScale(1.5)
#endif
        
        createLabel(text: "Settings",
                    fontSize: size.width/13,
                    fontColor: SKColor(red: 57/255, green: 100/255, blue: 113/255, alpha: 1),
                    position: CGPoint(x: size.width/2, y: size.height/1.45)
        )
        
//        createLabel(text: "  Sound \n effects",
//                    fontSize: size.width/20,
//                    fontColor: SKColor(red: 57/255, green: 100/255, blue: 113/255, alpha: 1),
//                    position: CGPoint(x: size.width/2.7, y: size.height/1.7)
//        )
        
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
        btn = createButton(name: .play, pos: 0, titleColor: SKColor(red: 255/255, green: 139/255, blue: 139/255, alpha: 1))
        btn2 = createButton(name: .settings, pos: 1, titleColor: SKColor(red: 255/255, green: 229/255, blue: 139/255, alpha: 1))
        btn3 = createButton(name: .shop, pos: 2, titleColor: SKColor(red: 139/255, green: 179/255, blue: 255/255, alpha: 1))
        
        addChild(btn)
        addChild(btn2)
        addChild(btn3)
        
        btn.setScale(0.5)
        btn2.setScale(0.5)
        btn3.setScale(0.5)
        
        
        switch2 = createSwitch(pos: CGPoint(x: size.width/1.45, y: size.height/2.05), name: "music")
        switch3 = createSwitch(pos: CGPoint(x: size.width/1.45, y: size.height/2.535), name: "vibration")
        
        addChild(switch2)
        addChild(switch3)
        
        
        self.isUserInteractionEnabled = true
        
#if os(tvOS)
        
        addTapGestureRecognizer()
        
#endif
    }
    
    func createButton(name: ButtonType, pos: Int, titleColor: SKColor) -> SKButton {
        let texture: SKTexture = SKTexture(imageNamed: "\(name.rawValue)")
        let title: SKLabelNode = SKLabelNode(text: "\(name.rawValue)")
        texture.filteringMode = .nearest
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
        addChild(title)
        
        return button
        
    }
    
    func changeSwitchImageState(switchButton: SKButton, state: inout Bool)  {
        
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
        
        let w: CGFloat = size.width / 6.0
        let h = w * texture.size().height / texture.size().width
        
        let switchButton: SKButton = SKButton(texture: texture,
                                              color: .clear,
                                              size: CGSize(width: w, height: h))
        switchButton.position = pos
        
#if os(macOS) || os(tvOS)
        switchButton.setScale(0.5)
#endif
        
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
        return switchButton
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
        
#if os(macOS) || os(tvOS)
        label.setScale(0.5)
#endif
    }
    
#if os(tvOS)
    
    var isToggle: Bool = true
    
    func addTapGestureRecognizer() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.tapped(sender:)))
        self.scene?.view?.addGestureRecognizer(tapRecognizer)
    }
    
    @objc func tapped(sender: AnyObject) {
        if (btn.isFocused) {
            let scene = GameScene.newGameScene()
            self.view?.presentScene(scene)
            scene.run(SKAction.wait(forDuration: 0.02))
            scene.view?.window?.rootViewController?.setNeedsFocusUpdate()
            scene.view?.window?.rootViewController?.updateFocusIfNeeded()
        } else if (btn2.isFocused) {
            let scene = SettingsScene.newGameScene()
            self.view?.presentScene(scene)
            scene.run(SKAction.wait(forDuration: 0.02))
            scene.view?.window?.rootViewController?.setNeedsFocusUpdate()
            scene.view?.window?.rootViewController?.updateFocusIfNeeded()
        } else if (btn3.isFocused) {
            let scene = EggScene.newGameScene()
            self.view?.presentScene(scene)
            scene.run(SKAction.wait(forDuration: 0.02))
            scene.view?.window?.rootViewController?.setNeedsFocusUpdate()
            scene.view?.window?.rootViewController?.updateFocusIfNeeded()
            
            print("botão azul")
            
        } else if (switch2.isFocused) {
            switchToggle(switchButton: switch2)
            
        } else {
            print("no hablo sua logica")
        }
    }

    #if os(tvOS) || os(macOS)
    
    func switchToggle(switchButton: SKButton) {
       
        toggleON.toggle()
            
        if toggleON {
                switchButton.texture = SKTexture(imageNamed: "switchON")
                
            } else {
                switchButton.texture = SKTexture(imageNamed: "switchOFF")
                
            }
        
    }
    
#endif
    
#endif
    
    override func didChangeSize(_ oldSize: CGSize) {
        super.didChangeSize(oldSize)
        
        setUpScene()
    }
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        setUpScene()
    }
}


#if os(tvOS)
extension SettingsScene {
    override var preferredFocusEnvironments: [UIFocusEnvironment] {
        return[switch2, switch3, btn, btn2, btn3]
    }
}
#endif

