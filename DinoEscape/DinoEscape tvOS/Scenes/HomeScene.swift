//
//  HomeScene.swift
//  DinoEscape tvOS
//
//  Created by Carolina Ortega on 01/04/22.
//

import Foundation
import SpriteKit
import AVFoundation

class HomeScene: MyScene {
    var btn = SKButton()
    var btn2 = SKButton()
    var btn3 = SKButton()
    var player = AVPlayer()
    var video = SKVideoNode(fileNamed: "gameplay.mov")
    
    class func newGameScene() -> HomeScene {
        let scene = HomeScene()
        scene.scaleMode = .resizeFill
        return scene
    }
    override func didMove(to view: SKView) {
        self.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapped(sender:)))
        
        view.addGestureRecognizer(tap)
    }
    func setUpScene() {
        self.isUserInteractionEnabled = true
        MusicService.shared.playLoungeMusic()
        GameCenterController.shared.setupActionPoint(location: .topLeading, showHighlights: true, isActive: true)

        backgroundColor = SKColor(red: 57/255, green: 100/255, blue: 113/255, alpha: 1)
        
        addTapGestureRecognizer()
        removeAllChildren()
        removeAllActions()
        
        video = setVideoNode()!
        addChild(video)
        video.play()

        let backgroundImage: SKSpriteNode = SKSpriteNode(imageNamed: "homeBackground-macOS")
        backgroundImage.position = CGPoint(x: size.width/2, y: size.height/2)
        backgroundImage.size = frame.size
        backgroundImage.zPosition = -5
        addChild(backgroundImage)

        let title: SKLabelNode = SKLabelNode(text: "D I N O  E S C A P E")
        title.fontName = "Aldrich-Regular"
        title.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        title.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        title.numberOfLines = 0
        title.fontColor = SKColor(red: 235/255, green: 231/255, blue: 198/255, alpha: 1)
        addChild(title)
        
        btn = createButton(name: .play, pos: 0, titleColor: SKColor(red: 255/255, green: 139/255, blue: 139/255, alpha: 1))
        addChild(btn)
        btn2 = createButton(name: .settings, pos: 1, titleColor: SKColor(red: 255/255, green: 229/255, blue: 139/255, alpha: 1))
        addChild(btn2)
        
        title.fontSize = 120
        title.position = CGPoint(x: size.width/2, y: size.height/1.11)
        
        btn.setScale(0.5)
        btn2.setScale(0.5)
        
    }
    
    func setVideoNode() -> SKVideoNode? {
        var video = ""
        var multiplier = 0.0
        video = "gameplayMac"
        multiplier = 0.85

        let videoNode: SKVideoNode? = {
            guard let urlString = Bundle.main.path(forResource: video, ofType: "mov") else {
                return nil
            }
            
            let url = URL(fileURLWithPath: urlString)
            let item = AVPlayerItem(url: url)
            player = AVPlayer(playerItem: item)
            return SKVideoNode(avPlayer: player)
        }()
        
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime,
                                                       object: player.currentItem, queue: nil)
                { notification in
                    self.player.seek(to: CMTime.zero)
                    self.player.play()
                }
        
        videoNode?.position = CGPoint(x: frame.midX, y: frame.midY)
        videoNode?.zPosition = -10
        videoNode?.setScale(multiplier)
        videoNode?.alpha = 0.8
        
        return videoNode
    }
    
    func createButton(name: ButtonType, pos: Int, titleColor: SKColor) -> SKButton {
        let texture: SKTexture = SKTexture(imageNamed: "\(name.rawValue)")
        texture.filteringMode = .nearest
        
        var title: SKLabelNode
        if name == .play {
            title = SKLabelNode(text: "Play".localized())
        } else {
            title = SKLabelNode(text: "Settings".localized())
        }
        
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
            self.video.removeFromParent()
            if name == .play {
                let scene = GameScene.newGameScene()
                print(UserDefaults.standard.integer(forKey: "DinoCoins"))

                self.view?.presentScene(scene)
                
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

    }
}

