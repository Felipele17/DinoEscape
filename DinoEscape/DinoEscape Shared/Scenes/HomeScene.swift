//
//  GameSceneIOS.swift
//  DinoEscape iOS
//
//  Created by Raphael Alkamim on 11/03/22.
//

import Foundation
import SpriteKit

class HomeScene: MyScene {
    
    var btn = SKButton()
    var btn2 = SKButton()
    var btn3 = SKButton()
    
    
    class func newGameScene() -> HomeScene {
        let scene = HomeScene()
        scene.scaleMode = .resizeFill
        return scene
    }
#if os( tvOS )
    override func didMove(to view: SKView) {
        self.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapped(sender:)))
        
        view.addGestureRecognizer(tap)
    }
#endif
    
    func setUpScene() {
        self.isUserInteractionEnabled = true
        

        backgroundColor = SKColor(red: 57/255, green: 100/255, blue: 113/255, alpha: 1)
        
#if os( tvOS )
        addTapGestureRecognizer()
#endif
        
        removeAllChildren()
        removeAllActions()
        
#if os(macOS)
        let backgroundImage: SKSpriteNode = SKSpriteNode(imageNamed: "homeBackground-macOS")
#elseif os(tvOS) || os(iOS)
        let backgroundImage: SKSpriteNode = SKSpriteNode(imageNamed: "homeBackground-iOS")
#endif
        
        backgroundImage.position = CGPoint(x: size.width/2, y: size.height/2)
        backgroundImage.size = frame.size
        backgroundImage.zPosition = -5
        addChild(backgroundImage)
        
        let title: SKLabelNode = SKLabelNode(text: "D I N O")
        title.fontName = "Aldrich-Regular"
        title.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        title.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        title.numberOfLines = 2
        title.fontColor = SKColor(red: 235/255, green: 231/255, blue: 198/255, alpha: 1)
        addChild(title)
        
        let subtitle: SKLabelNode = SKLabelNode(text: "E S C A P E")
        subtitle.fontName = "Aldrich-Regular"
        subtitle.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        subtitle.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        subtitle.numberOfLines = 2
        subtitle.fontColor = SKColor(red: 235/255, green: 231/255, blue: 198/255, alpha: 1)
        
        addChild(subtitle)
        btn = createButton(name: .play, pos: 0, titleColor: SKColor(red: 255/255, green: 139/255, blue: 139/255, alpha: 1))
        addChild(btn)
        btn2 = createButton(name: .settings, pos: 1, titleColor: SKColor(red: 255/255, green: 229/255, blue: 139/255, alpha: 1))
        addChild(btn2)
        btn3 = createButton(name: .shop, pos: 2, titleColor: SKColor(red: 139/255, green: 179/255, blue: 255/255, alpha: 1))
        addChild(btn3)
        
#if os(iOS)
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
                title.fontSize = 40
                title.position = CGPoint(x: size.width/2, y: size.height/1.07)
                
                subtitle.fontSize = 40
                subtitle.position = CGPoint(x: size.width/2, y: size.height/1.164)
                
                btn.setScale(0.9)
                btn2.setScale(0.9)
                btn3.setScale(0.9)
                
            } else {
                title.fontSize = 40
                title.position = CGPoint(x: size.width/2, y: size.height/1.09)
                
                subtitle.fontSize = 40
                subtitle.position = CGPoint(x: size.width/2, y: size.height/1.164)
            }

            
            
        default:
            print("oi")
        }

        
#elseif os(tvOS)
        title.setScale(1.5)
        title.position = CGPoint(x: size.width/2, y: size.height/1.09)
        subtitle.position = CGPoint(x: size.width/2, y: size.height/1.164)
        subtitle.setScale(1.5)
        
#elseif os(macOS)
        title.setScale(2)
        subtitle.setScale(2)
        title.position = CGPoint(x: size.width/2, y: size.height/1.07)
        subtitle.position = CGPoint(x: size.width/2, y: size.height/1.164)

        btn.setScale(0.6)
        btn2.setScale(0.6)
        btn3.setScale(0.6)
  
#endif
        
    }
    
    func createButton(name: ButtonType, pos: Int, titleColor: SKColor) -> SKButton {
        let texture: SKTexture = SKTexture(imageNamed: "\(name.rawValue)")
        texture.filteringMode = .nearest
        let title: SKLabelNode = SKLabelNode(text: "\(name.rawValue)")
        title.fontName = "Aldrich-Regular"
        title.fontSize = 20
        title.fontColor = titleColor
        
        
        let w: CGFloat = size.width / 4.8
        let h = w * texture.size().height / texture.size().width
        
        let button: SKButton = SKButton(texture: texture, color: .clear, size: CGSize(width: w, height: h))
        
        #if os(iOS) || os(tvOS)
        button.position = CGPoint(x: button.frame.width * 1 + CGFloat(pos) * button.frame.width * 1.4, y: size.height/5.4)
        title.position = CGPoint(x: button.frame.width * 1 + CGFloat(pos) * button.frame.width * 1.4, y: size.height/7.8)
        
        #elseif os(macOS)
        title.fontSize = 40
        button.position = CGPoint(x: button.frame.width * 0.55 + CGFloat(pos) * button.frame.width * 0.8, y: size.height/7.6)
        title.position = CGPoint(x: button.frame.width * 0.55 + CGFloat(pos) * button.frame.width * 0.8, y: size.height/27)
        
#endif
        
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
    
    
    override func didChangeSize(_ oldSize: CGSize) {
        super.didChangeSize(oldSize)
        
        setUpScene()
    }
    
#if os( tvOS )
    func addTapGestureRecognizer() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.tapped(sender:)))
        self.scene?.view?.addGestureRecognizer(tapRecognizer)
        
    }
    
    
    
    @objc func tapped(sender: AnyObject) {
        
        if (btn.isFocused){
            let scene = GameScene.newGameScene()
            self.view?.presentScene(scene)
            scene.run(SKAction.wait(forDuration: 0.02))
            scene.view?.window?.rootViewController?.setNeedsFocusUpdate()
            scene.view?.window?.rootViewController?.updateFocusIfNeeded()
        }
        else if (btn2.isFocused){
            let scene = SettingsScene.newGameScene()
            self.view?.presentScene(scene)
            scene.run(SKAction.wait(forDuration: 0.02))
            scene.view?.window?.rootViewController?.setNeedsFocusUpdate()
            scene.view?.window?.rootViewController?.updateFocusIfNeeded()
        }
        else if (btn3.isFocused){
            let scene = EggScene.newGameScene()
            self.view?.presentScene(scene)
            scene.run(SKAction.wait(forDuration: 0.02))
            scene.view?.window?.rootViewController?.setNeedsFocusUpdate()
            scene.view?.window?.rootViewController?.updateFocusIfNeeded()
        }
        else {
            print("não sei ler oq vc quer")
        }
    }
#endif
    
}

