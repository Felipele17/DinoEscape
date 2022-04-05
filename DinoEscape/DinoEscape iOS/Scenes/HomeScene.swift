//
//  HomeScene.swift
//  DinoEscape iOS
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
    
    func setUpScene() {
        self.isUserInteractionEnabled = true
        MusicService.shared.playLoungeMusic()
        GameCenterController.shared.setupActionPoint(location: .topLeading, showHighlights: true, isActive: true)
        backgroundColor = SKColor(red: 57/255, green: 100/255, blue: 113/255, alpha: 1)
        removeAllChildren()
        removeAllActions()
        video = setVideoNode()!
        addChild(video)
        video.play()
        
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
        
        btn = createButton(name: .play, pos: 0, titleColor: SKColor(red: 255/255, green: 139/255, blue: 139/255, alpha: 1))
        addChild(btn)
        btn2 = createButton(name: .settings, pos: 1, titleColor: SKColor(red: 255/255, green: 229/255, blue: 139/255, alpha: 1))
        addChild(btn2)
        btn3 = createButton(name: .shop, pos: 2, titleColor: SKColor(red: 139/255, green: 179/255, blue: 255/255, alpha: 1))
        addChild(btn3)
        
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
    
    func setVideoNode() -> SKVideoNode? {
        var video = ""
        var multiplier = 0.0
        switch UIDevice.current.userInterfaceIdiom{
        case .pad:
            video = "gameplayIpadOS"
            multiplier = 0.55
        case .phone:
        video = "gameplayIOS"
        multiplier = 0.35
        default:
            print("default")
        }

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
        
        switch name {
        case .play:
            title = SKLabelNode(text: "Play".localized())
        case .settings:
            title = SKLabelNode(text: "Settings".localized())
        case .shop:
            title = SKLabelNode(text: "Shop".localized())
        }
        title.fontName = "Aldrich-Regular"
        
        title.fontSize = 20
        title.fontColor = titleColor
        
        let width: CGFloat = size.width / 4.8
        let height = width * texture.size().height / texture.size().width
        
        let button: SKButton = SKButton(texture: texture, color: .clear, size: CGSize(width: width, height: height))
        button.position = CGPoint(x: button.frame.width * 1 + CGFloat(pos) * button.frame.width * 1.4, y: size.height/5.4)
        title.position = CGPoint(x: button.frame.width * 1 + CGFloat(pos) * button.frame.width * 1.4, y: size.height/7.8)
        
        button.selectedHandler = {
            self.video.removeFromParent()
            if name == .play {
                let scene = GameScene.newGameScene()
                print(UserDefaults.standard.integer(forKey: "DinoCoins"))
                self.view?.presentScene(scene)
                
            } else if name == .shop {
                print(UserDefaults.standard.integer(forKey: "DinoCoins"))
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

}
