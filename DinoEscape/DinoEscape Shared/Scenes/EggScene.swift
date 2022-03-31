//
//  EggScene.swift
//  DinoEscape iOS
//
//  Created by Leticia Utsunomiya on 15/03/22.
//

import Foundation
import SpriteKit

class EggScene: SKScene {
    
    var coins: Int = GameController.shared.gameData.player?.dinoCoins ?? 10000
    var premios: [String] = ["t-Rex", "t-Rex", "t-Rex", "t-Rex", "t-Rex", "t-Rex", "t-Rex", "t-Rex", "t-Rex", "t-Rex","brachiosaurus", "brachiosaurus", "brachiosaurus", "brachiosaurus", "brachiosaurus","chickenosaurus","stegosaurus", "stegosaurus", "stegosaurus","triceratops","veloci"]
    var timerButton: SKButton = SKButton()
    var moreButton: SKButton = SKButton()
    var premioDate: String = UserDefaults.standard.string(forKey: "premioDate") ?? "0"
    let formatter = DateFormatter()
    var eggNode = SKSpriteNode()

    
    class func newGameScene() -> EggScene {
        let scene = EggScene()
        scene.scaleMode = .resizeFill
        return scene
    }
    
    func setUpScene() {
        self.isUserInteractionEnabled = true
        GameCenterController.shared.setupActionPoint(location: .topLeading, showHighlights: false, isActive: false)

        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        
        let timePassed = calculateHours()

        
        backgroundColor = SKColor(red: 235/255, green: 231/255, blue: 198/255, alpha: 1)
        MusicService.shared.playLoungeMusic()
        
        removeAllChildren()
        removeAllActions()
        
        addChild(createReader(coins: coins))
        
        
        createSegButton(image: .eggs, pos: 0)
        createSegButton(image: .dinos, pos: 1)
        
        timerButton = createShopButtons(image: .daily, pos: 0)
        if timePassed < 24 {
            self.timerButton.isButtonEnabled = false
            self.timerButton.state = .disabled
        }
        
        addChild(timerButton)
        addChild(moreButton)
        
        
#if os(iOS) || os(tvOS)
        eggNode = SKSpriteNode(imageNamed: "ovo")
        eggNode.position = CGPoint(x: size.width/2, y: size.height/2)
        eggNode.size = CGSize(width: size.width/1.5, height: size.height/1.7)
        
#elseif os(macOS)
        eggNode = SKSpriteNode(imageNamed: "ovo-mac")
        eggNode.position = CGPoint(x: size.width/2, y: size.height/2)
        eggNode.size = CGSize(width: size.width/3, height: size.height/1.5)
        
#endif
        
        addChild(eggNode)
        
    }
    
    func createADSButton(pos: Int) -> SKButton {
        let texture: SKTexture = SKTexture(imageNamed: "plusDinocoin")
        texture.filteringMode = .nearest
        
#if os(iOS) || os(tvOS)
        let w: CGFloat = size.width / 16
#elseif os(macOS)
        let w: CGFloat = size.width / 20
#endif
        let h = w * texture.size().height / texture.size().width
        
        let adsButton: SKButton = SKButton(texture: texture, color: .clear, size: CGSize(width: w, height: h))
        
        adsButton.position = CGPoint(
            x: size.width/1.102,
            y: size.height/1.103)
        
        
        
        adsButton.selectedHandler = {
            print("ads")
            
        }
        
        return adsButton
        
    }
    
    func createShopButtons(image: EggType, pos: Int) -> SKButton {
        let texture: SKTexture = SKTexture(imageNamed: "\(image.rawValue)")
        texture.filteringMode = .nearest
        
#if os(iOS) || os(tvOS)
        let w: CGFloat = size.width / 3
#elseif os(macOS)
        let w: CGFloat = size.width / 7
#endif
        
        let h = w * texture.size().height / texture.size().width
        let buyButton: SKButton = SKButton(texture: texture, color: .clear, size: CGSize(width: w, height: h))
        
        
        
#if os(iOS) || os(tvOS)
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            buyButton.position = CGPoint(
                x: self.size.width / 2,
                y: size.height / 6 )
        case .pad:
            buyButton.position = CGPoint(
                x: self.size.width / 2,
                y: size.height / 7 )
        default:
            print("default")
        }
        
#elseif os(macOS)
        buyButton.position = CGPoint(
            x: self.size.width / 2 + CGFloat(pos) * buyButton.frame.width * 1.2,
            y: size.height / 10 )
        
#endif
        buyButton.selectedHandler = { [weak self] in
            guard let self = self else { return }
            if image == .daily {
                let premio = self.premios[Int.random(in: 0..<self.premios.count)]
                let skins = try? SkinDataModel.getSkins()
                
                if let skins = skins {
                    for i in skins {
                        if i.name == premio {
                            self.eggNode.texture = SKTexture(imageNamed: (i.image ?? "frameTrexBuySelected") + "BuySelected" )
                            self.eggNode.size = CGSize(width: self.size.height * 0.3, height: self.size.height * 0.3)
                            if i.isBought == false {
                                _ = try! SkinDataModel.buyDino(skin: i)
                            } else {
                                print("repetido")
                            }
                            break
                        }
                    }
                    
                    self.timerButton.isButtonEnabled = false
                    self.timerButton.state = .disabled

                    let dateTake = Date()
                    let dateString = self.formatter.string(from: dateTake)
                    
                    UserDefaults.standard.set(dateString, forKey: "premioDate")

                    
                }
            }
        }
        
        return buyButton
        
    }
    
    func calculateHours() -> Double{
        let dateTaken = formatter.date(from: premioDate)
        if let dateTaken = dateTaken {
            let diffSeconds = Date().timeIntervalSinceReferenceDate - dateTaken.timeIntervalSinceReferenceDate
            let hoursPassed = diffSeconds/(60.0 * 60.0)
                        
            return hoursPassed

        }
        return 25

    }
    
    func createSegButton(image: SegmentageType, pos: Int) {
        let texture: SKTexture = SKTexture(imageNamed: "\(image.rawValue)")
        texture.filteringMode = .nearest
        
#if os(iOS) || os(tvOS)
        let w: CGFloat = size.width / 3.5
        let h = w * texture.size().height / texture.size().width
        
#elseif os(macOS)
        let w: CGFloat = size.width / 10
        let h = w * texture.size().height / texture.size().width
        
#endif
        
        let segmentage: SKButton = SKButton(texture: texture, color: .blue, size: CGSize(width: w, height: h))
        
#if os(iOS) || os(tvOS)
        segmentage.position = CGPoint(
            x: segmentage.frame.width / 0.84 + CGFloat(pos) * segmentage.frame.width * 1.05,
            y: size.height / 1.2 )
        
#elseif os(macOS)
        segmentage.position = CGPoint(
            x: segmentage.frame.width / 0.228 + CGFloat(pos) * segmentage.frame.width * 1.24,
            y: size.height / 1.1 )
        
#endif
        
        segmentage.selectedHandler = {
            print("BOTAO APERTADO: \(pos)")
            switch image {
            case .eggs:
                self.view?.presentScene(EggScene.newGameScene())
            case .dinos:
                self.view?.presentScene(StoreScene.newGameScene())
            }
        }
        
        addChild(segmentage)
    }
    
    
    
    func createReader(coins: Int) -> SKSpriteNode {
        let reader = SKSpriteNode(color: .clear, size: CGSize(width: size.width, height: size.height))
        
        reader.addChild(createTotalCoin(coins: coins))
        reader.addChild(createADSButton(pos: 0))
        reader.addChild(createBackButton())
        return reader
    }
    
    func createTotalCoin(coins: Int) -> SKSpriteNode {
        let coinTotal = SKSpriteNode(color: .clear, size:CGSize(width: size.width, height: size.height) )
        
        
#if os(iOS) || os(tvOS)
        let w: CGFloat = size.width / 15
        let h = w * coinTotal.size.height / coinTotal.size.width / 2
        
#elseif os(macOS)
        let w: CGFloat = size.width / 20
        let h = w * coinTotal.size.height / coinTotal.size.width / 0.7
        
#endif
        
        let coin: SKSpriteNode = SKSpriteNode(imageNamed: "coin")
        
        
#if os(iOS) || os(tvOS)
        coin.position = CGPoint(x: size.width/1.6, y: size.height/1.103)
        coin.size = CGSize(width: w, height: h)
        
#elseif os(macOS)
        coin.position = CGPoint(x: size.width/1.4, y: size.height/1.103)
        coin.size = CGSize(width: w, height: h)
        
#endif
        
        let total: SKLabelNode = SKLabelNode(text:String(coins))
        total.fontName = "Aldrich-Regular"
        total.fontSize = 30
        total.position = CGPoint(x: size.width/1.30, y: size.height/1.12)
        
#if os(macOS)
        total.fontSize = 60
        total.position = CGPoint(x: size.width/1.24, y: size.height/1.125)
        
#endif
        total.numberOfLines = 1
        total.fontColor = SKColor(red: 221/255, green: 108/255, blue: 50/255, alpha: 1)
        
        coinTotal.addChild(coin)
        coinTotal.addChild(total)
        
        return coinTotal
    }
    
    func createBackButton() -> SKButton {
        
        let texture = SKTexture(imageNamed: "backButton")
        texture.filteringMode = .nearest
        
#if os(iOS) || os(tvOS)
        let w: CGFloat = size.width / 15
        let h = w * texture.size().height / texture.size().width
        let button: SKButton = SKButton(texture: texture, color: .clear, size: CGSize(width: w, height: h))
        button.position = CGPoint(x: size.width / 8 , y: size.height/1.103)
        button.selectedHandler = {
            self.view?.presentScene(HomeScene.newGameScene())
            
        }
        
#elseif os(macOS)
        let w: CGFloat = size.width / 20
        let h = w * texture.size().height / texture.size().width
        let button: SKButton = SKButton(texture: texture, color: .clear, size: CGSize(width: w, height: h))
        button.position = CGPoint(x: size.width / 12 , y: size.height/1.103)
        button.selectedHandler = {
            self.view?.presentScene(HomeScene.newGameScene())
            
        }
#endif
        
        return button
    }
    
    override func didChangeSize(_ oldSize: CGSize) {
        super.didChangeSize(oldSize)
        
        setUpScene()
    }
    
    
}
