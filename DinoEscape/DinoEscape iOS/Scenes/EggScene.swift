//
//  EggScene.swift
//  DinoEscape iOS
//
//  Created by Carolina Ortega on 01/04/22.
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
        
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            eggNode = SKSpriteNode(imageNamed: "ovo")
            eggNode.size = CGSize(width: size.width/1.5, height: size.height/1.7)
        case .pad:
            eggNode = SKSpriteNode(imageNamed: "ovo-mac")
            eggNode.size = CGSize(width: size.width/1.5, height: size.height/1.7)
        default:
            print("oi")
        }
        eggNode.position = CGPoint(x: size.width/2, y: size.height/2)

        addChild(eggNode)
        
    }
    
    func createShopButtons(image: EggType, pos: Int) -> SKButton {
        let texture: SKTexture = SKTexture(imageNamed: "\(image.rawValue)")
        texture.filteringMode = .nearest
        
        let w: CGFloat = size.width / 3

        let h = w * texture.size().height / texture.size().width
        let buyButton: SKButton = SKButton(texture: texture, color: .clear, size: CGSize(width: w, height: h))
        
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
        
        var w: CGFloat = 0
        var h: CGFloat = 0
        
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            w = size.width / 3.5
            h = w * texture.size().height / texture.size().width
        case .pad:
            w = size.width / 4.5
            h = w * texture.size().height / texture.size().width
        default:
            print("oi")
        }

        let segmentage: SKButton = SKButton(texture: texture, color: .blue, size: CGSize(width: w, height: h))
        
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            segmentage.position = CGPoint(
                x: segmentage.frame.width / 0.84 + CGFloat(pos) * segmentage.frame.width * 1.05,
                y: size.height / 1.2 )
        case .pad:
            segmentage.position = CGPoint(
                x: segmentage.frame.width / 0.59 + CGFloat(pos) * segmentage.frame.width * 1.05,
                y: size.height / 1.18 )
        default:
            print("oi")
            
        }
        
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
        reader.addChild(createBackButton())
        return reader
    }
    
    func createTotalCoin(coins: Int) -> SKSpriteNode {
        let coinTotal = SKSpriteNode(color: .clear, size:CGSize(width: size.width, height: size.height) )
       
        var w: CGFloat = 0
        var h: CGFloat = 0

        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            w = size.width / 15
            h = w * coinTotal.size.height / coinTotal.size.width / 1.5
        case .phone:
            w = size.width / 10
            h = w * coinTotal.size.height / coinTotal.size.width / 2.2

        default:
            print("oi")
            
        }
        let coin: SKSpriteNode = SKSpriteNode(imageNamed: "DinoCoin")
                
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            coin.position = CGPoint(x: size.width/1.2, y: size.height/1.085)
            coin.size = CGSize(width: w, height: h)
        case .phone:
            coin.position = CGPoint(x: size.width/1.2, y: size.height/1.103)
            coin.size = CGSize(width: w, height: h)
        default:
            print("oi")
            
        }
        
        let coinsLabel: SKLabelNode = SKLabelNode(text:String(coins))
        coinsLabel.fontName = "Aldrich-Regular"
        coinsLabel.horizontalAlignmentMode = .right

        switch UIDevice.current.userInterfaceIdiom {
        
        case .pad:
            coinsLabel.position = CGPoint(x: coin.position.x/1.08, y: size.height/1.105)
            coinsLabel.fontSize = 40

        case .phone:
            coinsLabel.position = CGPoint(x: coin.position.x/1.11, y: size.height/1.12)
            coinsLabel.fontSize = 30

        default:
            print("oi")
        
        }
        
        coinsLabel.numberOfLines = 1
        coinsLabel.fontColor = SKColor(red: 221/255, green: 108/255, blue: 50/255, alpha: 1)
        
        addChild(coin)
        addChild(coinsLabel)
        
        return coinTotal
    }
    
    func createBackButton() -> SKButton {
        
        let texture = SKTexture(imageNamed: "backButton")
        texture.filteringMode = .nearest
        
        let w: CGFloat = size.width / 15
        let h = w * texture.size().height / texture.size().width
        let button: SKButton = SKButton(texture: texture, color: .clear, size: CGSize(width: w, height: h))
        button.position = CGPoint(x: size.width / 8 , y: size.height/1.103)
        button.selectedHandler = {
            self.view?.presentScene(HomeScene.newGameScene())
            
        }
        return button
    }
    
    override func didChangeSize(_ oldSize: CGSize) {
        super.didChangeSize(oldSize)
        
        setUpScene()
    }
    
    
}
