//
//  EggScene.swift
//  DinoEscape iOS
//
//  Created by Leticia Utsunomiya on 15/03/22.
//

import Foundation
import SpriteKit

class EggScene: SKScene {
    
    var coins: Int = 1000
    
    class func newGameScene() -> EggScene {
        let scene = EggScene()
        scene.scaleMode = .resizeFill
        return scene
    }
    
    func setUpScene() {
        self.isUserInteractionEnabled = true
        
        backgroundColor = SKColor(red: 235/255, green: 231/255, blue: 198/255, alpha: 1)
    
        removeAllChildren()
        removeAllActions()
        
        addChild(createReader(coins: coins))
        
        createSegButton(image: .eggs, pos: 0, name: .ovo)
        createSegButton(image: .dinos, pos: 1, name: .dinos)
        
        createShopButtons(image: .daily, pos: 0, name: .dailyreward)
        createShopButtons(image: .chance, pos: 1, name: .onemorechance)
        
        let dinoChoosed: SKSpriteNode = SKSpriteNode(imageNamed: "ovo")
        
        dinoChoosed.position = CGPoint(x: size.width/2, y: size.height/2)
        dinoChoosed.size = CGSize(width: size.width/1.5, height: size.height/1.7)
        addChild(dinoChoosed)
        
    }
    
//    func createADSButton(pos: Int) -> SKButton {
//        let texture: SKTexture = SKTexture(imageNamed: "buttonYellow")
//        texture.filteringMode = .nearest
//        
//        let w: CGFloat = size.width / 4
//        let h = w * texture.size().height / texture.size().width
//        
//        let adsButton: SKButton = SKButton(texture: texture, color: .clear, size: CGSize(width: w, height: h))
//        
//        adsButton.position = CGPoint(
//            x: adsButton.frame.width / 1.1 + CGFloat(pos) * adsButton.frame.width * 1.2,
//            y: size.height / 1.1 )
//        
//        
//        
//        adsButton.selectedHandler = {
//            print("ads")
//            
//        }
//        
//        return adsButton
//        
//    }
    
    func createShopButtons(image: EggType, pos: Int, name: StoreStrings ) {
        let texture: SKTexture = SKTexture(imageNamed: "\(image.rawValue)")
        texture.filteringMode = .nearest
        
        let w: CGFloat = size.width / 3
        let h = w * texture.size().height / texture.size().width
        
        let buyButton: SKButton = SKButton(texture: texture, color: .clear, size: CGSize(width: w, height: h))
        
        buyButton.position = CGPoint(
            x: buyButton.frame.width / 1.1 + CGFloat(pos) * buyButton.frame.width * 1.2,
            y: size.height / 6 )
        
        
        
        buyButton.selectedHandler = {
            print(name)
            
        }
        let text: SKLabelNode = SKLabelNode(text: "\(name.rawValue)")
        text.fontName = "Aldrich-Regular"
        text.fontSize = 18
        text.numberOfLines = 1
        text.fontColor = SKColor(red: 1, green: 1, blue: 1, alpha: 1)
        text.position = CGPoint(x: buyButton.size.width/2, y: buyButton.size.height/2)
       
        addChild(buyButton)
        buyButton.addChild(text)
        
    }
    
    
    func createSegButton(image: SegmentageType, pos: Int, name: StoreStrings) {
        let texture: SKTexture = SKTexture(imageNamed: "\(image.rawValue)")
        texture.filteringMode = .nearest
        
        let w: CGFloat = size.width / 3.5
        let h = w * texture.size().height / texture.size().width
        
        let segmentage: SKButton = SKButton(texture: texture, color: .blue, size: CGSize(width: w, height: h))
        
        segmentage.position = CGPoint(
            x: segmentage.frame.width / 0.84 + CGFloat(pos) * segmentage.frame.width * 1.05,
            y: size.height / 1.2 )
        
        segmentage.selectedHandler = {
            print("BOTAO APERTADO: \(pos)")
            switch image {
            case .eggs:
                self.view?.presentScene(EggScene.newGameScene())
            case .dinos:
                self.view?.presentScene(StoreScene.newGameScene())
            }
            /*
            if name == .eggs {
                self.view?.presentScene(EggScene.newGameScene())
            } else if name == .dinos {
                self.view?.presentScene(StoreScene.newGameScene())
            } else {
                print("out of the range")
            }
             */
        }
        
        let text: SKLabelNode = SKLabelNode(text: "\(name.rawValue)")
        text.fontName = "Aldrich-Regular"
        text.fontSize = 20
        text.numberOfLines = 1
        text.fontColor = SKColor(red: 1, green: 1, blue: 1, alpha: 1)
        text.position = CGPoint(x: segmentage.size.width, y: segmentage.size.height)
        
        addChild(segmentage)
        segmentage.addChild(text)
    }
        
    
    func createDino(name: DinoType, posX: Int, posY: Int) -> SKButton {
        let texture: SKTexture = SKTexture(imageNamed: "\(name.rawValue)")
        texture.filteringMode = .nearest
        
        let w: CGFloat = size.width / 4.8
        let h = w * texture.size().height / texture.size().width
        
        let dinoButton: SKButton = SKButton(texture: texture, color: .clear, size: CGSize(width: w, height: h))
        
        
        dinoButton.position = CGPoint(
            x: dinoButton.frame.width / 0.77 + CGFloat(posX) * dinoButton.frame.width * 1.1,
            y: size.height / 1.6 + CGFloat(posY) * dinoButton.frame.height * 1.2 )
        
        
        
        dinoButton.selectedHandler = {
            print(name)
            
        }
        
        return dinoButton
        
    }
    
    func createReader(coins: Int) -> SKSpriteNode {
        let reader = SKSpriteNode(color: .clear, size: CGSize(width: size.width, height: size.height))
        
        reader.addChild(createTotalCoin(coins: coins))
//        reader.addChild(createADSButton(pos: 0))
        return reader
    }
    
    func createTotalCoin(coins: Int) -> SKSpriteNode {
        let coinTotal = SKSpriteNode(color: .clear, size:CGSize(width: size.width, height: size.height) )
        
        
        let w: CGFloat = size.width / 20
        let h = w * coinTotal.size.height / coinTotal.size.width
        
        let coin: SKSpriteNode = SKSpriteNode(imageNamed: "coin")
        coin.position = CGPoint(x: size.width/1.5, y: size.height/1.1)
        coin.size = CGSize(width: w, height: h)
        
        let total: SKLabelNode = SKLabelNode(text:String(coins))
        total.fontName = "Aldrich-Regular"
        total.fontSize = 30
        total.numberOfLines = 1
        total.fontColor = SKColor(red: 221/255, green: 108/255, blue: 50/255, alpha: 1)
        total.position = CGPoint(x: size.width/1.25, y: size.height/1.115)
        
        coinTotal.addChild(coin)
        coinTotal.addChild(total)
        
        return coinTotal
    }
    
    
    override func didChangeSize(_ oldSize: CGSize) {
        super.didChangeSize(oldSize)
        
        setUpScene()
    }
   
    
}
