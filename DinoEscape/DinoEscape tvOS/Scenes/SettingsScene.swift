//
//  SettingsScene.swift
//  DinoEscape tvOS
//
//  Created by Carolina Ortega on 01/04/22.
//

import Foundation
import SpriteKit


class SettingsScene: MyScene {
        
    // buttons
    var btn = SKButton()
    var btn2 = SKButton()
    var btn3 = SKButton()
    
    // switches
    var switch2 = SKButton()
    var switch3 = SKButton()
    
    //invisible button
    var guideButton = SKButton()

    var toggleON: Bool = true
    
    let node = SKButton()
    
    class func newGameScene() -> SettingsScene {
        let scene = SettingsScene()
        scene.scaleMode = .resizeFill
        return scene
    }
    
    func setUpScene() {
        MusicService.shared.playLoungeMusic()
        backgroundColor = SKColor(red: 235/255, green: 231/255, blue: 198/255, alpha: 1)
        removeAllChildren()
        removeAllActions()
        
        let backgroundImage: SKSpriteNode = SKSpriteNode(imageNamed: "homeBackground-macOS")
        backgroundImage.position = CGPoint(x: size.width/2, y: size.height/2)
        backgroundImage.size = frame.size
        backgroundImage.zPosition = -5
        addChild(backgroundImage)
        
        let title: SKLabelNode = SKLabelNode(text: "R U N  D I N O,  R U N !")
        title.fontName = "Aldrich-Regular"
        title.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        title.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        title.numberOfLines = 0
        title.fontColor = SKColor(red: 235/255, green: 231/255, blue: 198/255, alpha: 1)
        addChild(title)
        
        createLabel(text: "Settings".localized(),
                    fontSize: size.width/13,
                    fontColor: SKColor(red: 57/255, green: 100/255, blue: 113/255, alpha: 1),
                    position: CGPoint(x: size.width/2, y: size.height/1.55)
        )
        
        
        createLabel(text: "Music".localized(),
                    fontSize: size.width/20,
                    fontColor: SKColor(red: 57/255, green: 100/255, blue: 113/255, alpha: 1),
                    position: CGPoint(x: size.width/2.9, y: size.height/1.9)
        )

        guideButton.position = CGPoint(x: self.size.width/1.5, y:  self.size.height/15)
        guideButton.size = CGSize(width: 90, height: 90)
        addChild(guideButton)
        
        btn = createButton(name: .play, pos: 0, titleColor: SKColor(red: 255/255, green: 139/255, blue: 139/255, alpha: 1))
        btn2 = createButton(name: .settings, pos: 1, titleColor: SKColor(red: 255/255, green: 229/255, blue: 139/255, alpha: 1))
        
        addChild(btn)
        addChild(btn2)
        
        switch2 = createSwitch(pos: CGPoint(x: size.width/1.5, y: size.height/1.9), type: .music)
        addChild(switch2)
        
        title.fontSize = 120
        title.position = CGPoint(x: size.width/2, y: size.height/1.11)
        
        btn.setScale(0.5)
        btn2.setScale(0.5)

    }
    
    func createButton(name: ButtonType, pos: Int, titleColor: SKColor) -> SKButton {
        let texture: SKTexture = SKTexture(imageNamed: "\(name.rawValue)")
        let title: SKLabelNode = SKLabelNode(text: "\(name.rawValue.localized())")
        texture.filteringMode = .nearest
        title.fontName = "Aldrich-Regular"
        title.fontSize = 20
        title.fontColor = titleColor
        
        let w: CGFloat = size.width / 4.8
        let h = w * texture.size().height / texture.size().width
        
        let button: SKButton = SKButton(texture: texture, color: .clear, size: CGSize(width: w, height: h))
        
        title.fontSize = 40
        button.position = CGPoint(x: button.frame.width * 0.55 + CGFloat(pos) * button.frame.width * 0.85, y: size.height/7.6)
        title.position = CGPoint(x: button.frame.width * 0.55 + CGFloat(pos) * button.frame.width * 0.85, y: size.height/27)
        
        button.selectedHandler = {
            if name == .play {
                self.view?.presentScene(GameScene.newGameScene())
            } else if name == .settings {
                self.view?.presentScene(SettingsScene.newGameScene())
            } else {
                print("out of range")
            }
        }
        addChild(title)
        
        return button
        
    }
    
    func changeSwitchMusic() -> String {
        var imageName : String
        if UserDefaults.standard.bool(forKey: "music") == true {
            imageName = "switchON"
        } else {
            imageName = "switchOFF"
        }
        return imageName
    }
    
    func changeSwitchVibration() -> String {
        var imageName : String
        if UserDefaults.standard.bool(forKey: "vibration") == true {
            imageName = "switchON"
        } else {
            imageName = "switchOFF"
        }
        return imageName
    }
  
    func createSwitch(pos: CGPoint, type: SwitchType) -> SKButton {
                
        let texture: SKTexture
        
        switch type {
        case .music:
            addTapGestureRecognizer()
            texture = SKTexture(imageNamed: "\(self.changeSwitchMusic())")
            
        case .vibration:
            texture = SKTexture(imageNamed: "\(self.changeSwitchVibration())")

        }
        
        texture.filteringMode = .nearest
        
        
        let w: CGFloat = size.width / 6.0
        let h = w * texture.size().height / texture.size().width
        
        let switchButton: SKButton = SKButton(texture: texture,
                                              color: .clear,
                                              size: CGSize(width: w, height: h))
        switchButton.position = pos
        switchButton.setScale(0.5)
        
        switchButton.selectedHandler = {
            switch type {
            case .music:
                MusicService.shared.updateUserDefaults()
                switchButton.texture =  SKTexture(imageNamed: "\(self.changeSwitchMusic())")
                MusicService.shared.playLoungeMusic()
                
            case .vibration:
                HapticService.shared.updateUserDefaults()
                switchButton.texture =  SKTexture(imageNamed: "\(self.changeSwitchVibration())")
                HapticService.shared.addVibration(haptic: "Haptic")
                
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
        
        label.setScale(0.5)
    }
        
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
        } else if (switch2.isFocused) {
            switchToggle(switchButton: switch2)
            
        } else if (switch3.isFocused) {
            switchToggle(switchButton: switch3)
            
        } else {
            print("no hablo sua logica")
        }
    }
        
    func switchToggle(switchButton: SKButton) {
        
        toggleON.toggle()
        
        if toggleON {
            switchButton.texture = SKTexture(imageNamed: "switchON")
            
        } else {
            switchButton.texture = SKTexture(imageNamed: "switchOFF")
            
        }
        
        
    }
    
    override func didChangeSize(_ oldSize: CGSize) {
        super.didChangeSize(oldSize)
        
        setUpScene()
    }
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        setUpScene()
    }
}

extension SettingsScene {
    override var preferredFocusEnvironments: [UIFocusEnvironment] {
        return[switch2, switch3, btn, btn2, btn3]
    }
}

