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
        
        //backgroundColor = SKColor(red: 235/255, green: 231/255, blue: 198/255, alpha: 1)
        backgroundColor = SKColor(red: 35/255, green: 21/255, blue: 198/255, alpha: 1)
    
        removeAllChildren()
        removeAllActions()
        
        addChild(createReader(coins: coins))
        
        createSegButton(name: .eggs ,pos: 0)
        createSegButton(name: .dinos ,pos: 1)
        
        createShopButtons(name: .buy, pos: 0)
        createShopButtons(name: .buy, pos: 1)
        
        let egg: SKSpriteNode = SKSpriteNode(imageNamed: "T-Rex")
        
        egg.position = CGPoint(x: size.width/2, y: size.height/2.1)
        egg.size = CGSize(width: size.width/1.5, height: size.height/2)
        addChild(egg)
        
    }
    
    func createADSButton(pos: Int) -> SKButton {
        let texture: SKTexture = SKTexture(imageNamed: "Buy")
        texture.filteringMode = .nearest
        
        let w: CGFloat = size.width / 4
        let h = w * texture.size().height / texture.size().width
        
        let adsButton: SKButton = SKButton(texture: texture, color: .clear, size: CGSize(width: w, height: h))
        
        adsButton.position = CGPoint(
            x: adsButton.frame.width / 1.1 + CGFloat(pos) * adsButton.frame.width * 1.2,
            y: size.height / 1.15 )
        
        
        
        adsButton.selectedHandler = {
            print("ads")
            
        }
        
        return adsButton
        
    }
    
    func createShopButtons(name: BuyButtonType, pos: Int ) {
        let texture: SKTexture = SKTexture(imageNamed: "\(name.rawValue)")
        texture.filteringMode = .nearest
        
        let w: CGFloat = size.width / 3
        let h = w * texture.size().height / texture.size().width
        
        let buyButton: SKButton = SKButton(texture: texture, color: .clear, size: CGSize(width: w, height: h))
        
        buyButton.position = CGPoint(
            x: buyButton.frame.width / 1.1 + CGFloat(pos) * buyButton.frame.width * 1.2,
            y: size.height / 6.5 )
        
        
        
        buyButton.selectedHandler = {
            print(name)
            
        }
        
        addChild(buyButton)
        
    }
    
    
    func createSegButton(name: SegmentageType, pos: Int) {
        let texture: SKTexture = SKTexture(imageNamed: "\(name.rawValue)")
        texture.filteringMode = .nearest
        
        let w: CGFloat = size.width / 3.5
        let h = w * texture.size().height / texture.size().width
        
        let segmentage: SKButton = SKButton(texture: texture, color: .blue, size: CGSize(width: w, height: h))
        
        segmentage.position = CGPoint(
            x: segmentage.frame.width / 0.84 + CGFloat(pos) * segmentage.frame.width * 1.05,
            y: size.height / 1.26 )
        
        segmentage.selectedHandler = {
            if name == .eggs {
                self.view?.presentScene(EggScene.newGameScene())
            } else if name == .dinos {
                self.view?.presentScene(StoreScene.newGameScene())
            } else {
                print("out of the range")
            }
        }
        
        addChild(segmentage)
        
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
        reader.addChild(createADSButton(pos: 0))
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
        total.position = CGPoint(x: size.width/1.25, y: size.height/1.15)
        
        coinTotal.addChild(coin)
        coinTotal.addChild(total)
        
        return coinTotal
    }
    
    
    override func didChangeSize(_ oldSize: CGSize) {
        super.didChangeSize(oldSize)
        
        setUpScene()
    }
   
    
}
