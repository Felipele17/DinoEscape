//
//  SettingsScene.swift
//  DinoEscape iOS
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
    var toggleON: Bool = true
    
    //invisible button
    var guideButton = SKButton()

    // music
    var musicButton = SKButton()
    
    
    class func newGameScene() -> SettingsScene {
        let scene = SettingsScene()
        scene.scaleMode = .resizeFill
        return scene
    }
    
    func setUpScene() {
        
        #if os(tvOS)
        addTapGestureRecognizer()
        #endif
        
        MusicService.shared.playLoungeMusic()
        backgroundColor = SKColor(red: 235/255, green: 231/255, blue: 198/255, alpha: 1)
        removeAllChildren()
        removeAllActions()

        let backgroundImage: SKSpriteNode = SKSpriteNode(imageNamed: "homeBackground-iOS")
        backgroundImage.position = CGPoint(x: size.width/2, y: size.height/2)
        backgroundImage.size = frame.size
        backgroundImage.zPosition = -5
        addChild(backgroundImage)
        
        let title: SKLabelNode = SKLabelNode(text: "R U N,  D I N O")
        title.fontName = "Aldrich-Regular"
        title.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        title.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        title.numberOfLines = 2
        title.fontColor = SKColor(red: 235/255, green: 231/255, blue: 198/255, alpha: 1)
        addChild(title)
        
        let subtitle: SKLabelNode = SKLabelNode(text: "R U N !")
        subtitle.fontName = "Aldrich-Regular"
        subtitle.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        subtitle.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        subtitle.numberOfLines = 2
        subtitle.fontColor = SKColor(red: 235/255, green: 231/255, blue: 198/255, alpha: 1)
        
        addChild(subtitle)

        createLabel(text: "Settings".localized(),
                    fontSize: size.width/13,
                    fontColor: SKColor(red: 57/255, green: 100/255, blue: 113/255, alpha: 1),
                    position: CGPoint(x: size.width/2, y: size.height/1.45)
        )
        
        
        createLabel(text: "Music".localized(),
                    fontSize: size.width/20,
                    fontColor: SKColor(red: 57/255, green: 100/255, blue: 113/255, alpha: 1),
                    position: CGPoint(x: size.width/2.9, y: size.height/1.7)
        )
        
        createLabel(text: "Vibration".localized(),
                    fontSize: size.width/20,
                    fontColor: SKColor(red: 57/255, green: 100/255, blue: 113/255, alpha: 1),
                    position: CGPoint(x: size.width/2.9, y: size.height/2.07)
        )

        btn = createButton(name: .play, pos: 0, titleColor: SKColor(red: 255/255, green: 139/255, blue: 139/255, alpha: 1))
        btn2 = createButton(name: .settings, pos: 1, titleColor: SKColor(red: 255/255, green: 229/255, blue: 139/255, alpha: 1))
        btn3 = createButton(name: .shop, pos: 2, titleColor: SKColor(red: 139/255, green: 179/255, blue: 255/255, alpha: 1))
        
        addChild(btn)
        addChild(btn2)
        addChild(btn3)
        
        switch2 = createSwitch(pos: CGPoint(x: size.width/1.5, y: size.height/1.7), type: .music)
        addChild(switch2)
        switch3 = createSwitch(pos: CGPoint(x: size.width/1.5, y: size.height/2.05), type: .vibration)
        addChild(switch3)
        
        switch UIDevice.current.userInterfaceIdiom{
        case .pad:
            title.fontSize = size.width/12
            title.position = CGPoint(x: size.width/2, y: size.height/1.07)
            
            subtitle.fontSize = size.width/12
            subtitle.position = CGPoint(x: size.width/2, y: size.height/1.164)
            
            btn.setScale(0.8)
            btn2.setScale(0.8)
            btn3.setScale(0.8)
            
        case .phone:
            if UIDevice.current.name == "iPhone 8" {
                title.fontSize = 35
                title.position = CGPoint(x: size.width/2, y: size.height/1.07)
                
                subtitle.fontSize = 40
                subtitle.position = CGPoint(x: size.width/2, y: size.height/1.164)
                
                btn.setScale(0.9)
                btn2.setScale(0.9)
                btn3.setScale(0.9)
                
            } else {
                title.fontSize = 35
                title.position = CGPoint(x: size.width/2, y: size.height/1.09)
                
                subtitle.fontSize = 40
                subtitle.position = CGPoint(x: size.width/2, y: size.height/1.164)
            }
            
            
            
        default:
            print("oi")
        }
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
                
        switchButton.selectedHandler = {
            switch type {
            case .music:
                #if os(tvOS)
                self.addTapGestureRecognizer()
                #endif
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


