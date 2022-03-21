//
//  StoreSceneIOS.swift
//  DinoEscape iOS
//
//  Created by Raphael Alkamim on 11/03/22.
//

import Foundation
import SpriteKit

class StoreScene: MyScene {
    
    var coins: Int = 1000
    var dinoChoosed: String = "T-Rex"
    
    class func newGameScene() -> StoreScene {
        let scene = StoreScene()
        scene.scaleMode = .resizeFill
        return scene
    }
    
    
    func setUpScene() {
        self.isUserInteractionEnabled = true
        
        backgroundColor = SKColor(red: 235/255, green: 231/255, blue: 198/255, alpha: 1)

        
        removeAllChildren()
        removeAllActions()
        
        addChild(createReader(coins: coins))
        
        createSegButton(image: .eggs, pos: 0)
        createSegButton(image: .dinos, pos: 1)
        
   
        addChild(createGallery())
        
        createShopButtons(image: .buy, pos: 0)
        createShopButtons(image: .selected, pos: 1)
        
        
        
    }
    
    
    func setDinoImage() {
        let dinoImage: SKSpriteNode = SKSpriteNode(imageNamed: dinoChoosed)
        
        dinoImage.position = CGPoint(x: size.width/2, y: size.height/2.6)
        dinoImage.size = CGSize(width: size.width/1.5, height: size.height/3)
        addChild(dinoImage)
    }
    
    func createADSButton(pos: Int) -> SKButton {
        let texture: SKTexture = SKTexture(imageNamed: "plusDinocoin")
        texture.filteringMode = .nearest
        
        let w: CGFloat = size.width/16
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
    
    func createShopButtons(image: BuyButtonType, pos: Int) {
        let texture: SKTexture = SKTexture(imageNamed: "\(image.rawValue)")
        texture.filteringMode = .nearest
        
        let w: CGFloat = size.width / 3
        let h = w * texture.size().height / texture.size().width
        
        let buyButton: SKButton = SKButton(texture: texture, color: .clear, size: CGSize(width: w, height: h))
        buyButton.position = CGPoint(
            x: buyButton.frame.width / 1.1 + CGFloat(pos) * buyButton.frame.width * 1.2,
            y: size.height / 6 )
        
        
        
        buyButton.selectedHandler = {

            
        }
        
        
        addChild(buyButton)
        
    }
    
    
    func createSegButton(image: SegmentageType, pos: Int) {
        let texture: SKTexture = SKTexture(imageNamed: "\(image.rawValue)")
        texture.filteringMode = .nearest
        
        let w: CGFloat = size.width / 3.5
        let h = w * texture.size().height / texture.size().width
        
        let segmentage: SKButton = SKButton(texture: texture, color: .blue, size: CGSize(width: w, height: h))
        
        
        segmentage.position = CGPoint(
            x: segmentage.frame.width / 0.84 + CGFloat(pos) * segmentage.frame.width * 1.05,
            y: size.height / 1.2 )
        
        
        segmentage.selectedHandler = {
            print("\(pos)")
            switch image {
            case .eggs:
                self.view?.presentScene(EggScene.newGameScene())
            case .dinos:
                self.view?.presentScene(StoreScene.newGameScene())
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
        reader.addChild(createBackButton())
        return reader
    }
    
    
    func createTotalCoin(coins: Int) -> SKSpriteNode {
        let coinTotal = SKSpriteNode(color: .clear, size:CGSize(width: size.width, height: size.height) )
        
        
        let w: CGFloat = size.width / 15
        let h = w * coinTotal.size.height / coinTotal.size.width / 2
        
        let coin: SKSpriteNode = SKSpriteNode(imageNamed: "coin")
        coin.position = CGPoint(x: size.width/1.6, y: size.height/1.103)
        coin.size = CGSize(width: w, height: h)
        
        let total: SKLabelNode = SKLabelNode(text:String(coins))
        total.fontName = "Aldrich-Regular"
        total.fontSize = 30
        total.numberOfLines = 1
        total.fontColor = SKColor(red: 221/255, green: 108/255, blue: 50/255, alpha: 1)
        total.position = CGPoint(x: size.width/1.30, y: size.height/1.12)
        
        coinTotal.addChild(coin)
        coinTotal.addChild(total)
        
        
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
    
    
    func createGallery() -> SKSpriteNode {
        let gallery = SKSpriteNode(color: .clear, size: CGSize(width: size.width, height: size.height))
        //let button = createDino(name: .t_rex, posX: 0, posY: 0)
        var vetor = [[DinoType.brachiosaurus, DinoType.t_rex], [DinoType.triceratops, DinoType.brachiosaurus], [DinoType.chickenosaurus, DinoType.stegosaurus]]
        
        for i in 0..<3{
            for j in 0..<2{
                
                
                    let button = createDino(name: vetor[i][j], posX: i, posY: j)
                    gallery.addChild(button)
                
            }
        }
        
        
        return gallery
    }
    
    
    override func didChangeSize(_ oldSize: CGSize) {
        super.didChangeSize(oldSize)
        
        setUpScene()
    }
   
    
}
