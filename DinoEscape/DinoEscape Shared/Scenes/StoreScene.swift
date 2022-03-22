//
//  StoreSceneIOS.swift
//  DinoEscape iOS
//
//  Created by Raphael Alkamim on 11/03/22.
//

import Foundation
import SpriteKit

class StoreScene: MyScene {
    
    let vetor = try! SkinDataModel.getSkins()
    var coins: Int = 1000
    var dinoChoosed: String = "T-Rex"
    var dinoImage = SKSpriteNode()
    var buyButton = SKButton()
    var selectButton = SKButton()
    var gallery = SKSpriteNode()
    var selectedDino = SkinData()
    
    var isBought: String = "purchasedButton" {
        didSet {
            buyButton.texture = SKTexture(imageNamed: self.isBought)
        }
    }
    
    var isSelected: String = "selectedButton" {
        didSet {
            selectButton.texture = SKTexture(imageNamed: self.isSelected)
        }
    }

    
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
        
        setDinoImage(image: "t-RexLeft0")
        
        addChild(dinoImage)
        
        let skins = try! SkinDataModel.getSkins()
        if skins.count != 0{
            gallery = createGallery()
            addChild(gallery)

        }
        
        self.buyButton = createShopButtons(image: self.isBought, pos: 0)
        self.selectButton = createShopButtons(image: self.isSelected, pos: 1)
        addChild(self.selectButton)
        addChild(buyButton)
        
    }
    
    
    
    func setDinoImage(image: String) {

        let square: SKShapeNode = SKShapeNode(rect: CGRect(
            x: size.width/6,
            y: size.height/4.6,
            width: size.width/1.5,
            height: size.height/3))
        
        square.lineWidth = 10
        square.strokeColor = SKColor(red: 100, green: 100, blue: 100, alpha: 1)
        
        
        addChild(square)
        
        dinoImage.position = CGPoint(x:size.width/2, y: size.width/1.2)
        dinoImage.size = CGSize(width: size.width/1.5, height: size.height/3)
        dinoImage.texture = SKTexture(imageNamed: image)
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
    
    func createShopButtons(image: String, pos: Int) -> SKButton {
        buyButton.removeFromParent()
        selectButton.removeFromParent()
        
        let texture: SKTexture = SKTexture(imageNamed:image)
        texture.filteringMode = .nearest
        
        let w: CGFloat = size.width / 3
        let h = w * texture.size().height / texture.size().width
        
        let buyButton: SKButton = SKButton(texture: texture, color: .clear, size: CGSize(width: w, height: h))
        buyButton.position = CGPoint(
            x: buyButton.frame.width / 1.1 + CGFloat(pos) * buyButton.frame.width * 1.2,
            y: size.height / 6 )
        
        if image == "selectButton"{
            self.isSelected = "selectedButton"
        }
        else if image == "purchasedButton" {
            self.isBought = "purchasedButton"
        }
        else if image == "selectedButton" {
            self.isSelected = "selectedButton"
        }
        else if image == "purchasedButton"{
            self.isSelected = "purchasedButton"
        }
//        switch image {
//        case .selected:
//            buyButton.selectedHandler = {
//                self.isSelected = "selectedButton"
//                print("clicou")
//            }
//        case .buy:
//            buyButton.selectedHandler = {
//                #warning("Colocar conferencias de moeda")
//                self.isBought = "purchasedButton"
//                try! SkinDataModel.buyDino(skin: self.selectedDino)
//                print("clicou")
//            }
//        case .select:
//            buyButton.selectedHandler = {
//                self.isSelected = "selectedButton"
//                try! SkinDataModel.selectSkin(skin: self.selectedDino)
//                print("clicouaqui")
//            }
//        case .purchased:
//            self.isSelected = "purchasedButton"
//        }
//
        return buyButton
        
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
        
    
    func createDino(name: SkinData, posX: Int, posY: Int, isBought: Bool, isSelected: Bool) -> SKButton {
        let texture: SKTexture = SKTexture(imageNamed: name.image ?? "frameTrex")
        texture.filteringMode = .nearest
        
        let w: CGFloat = size.width / 4.8
        let h = w * texture.size().height / texture.size().width
        
        let dinoButton: SKButton = SKButton(texture: texture, color: .clear, size: CGSize(width: w, height: h))
        
        
        dinoButton.position = CGPoint(
            x: dinoButton.frame.width / 0.77 + CGFloat(posX) * dinoButton.frame.width * 1.1,
            y: size.height / 1.6 + CGFloat(posY) * dinoButton.frame.height * 1.2 )
        
        
        
        dinoButton.selectedHandler = { [self] in
            if name.name == "t-Rex" {
                print(name)
                self.setDinoImage(image: "t-RexLeft0" )
            }
            else if name.name == "brachiosaurus" {
                print(name)
                self.setDinoImage(image: "brachiosaurusLeft0" )
            }
            else if name.name == "chickenosaurus" {
                print(name)
                self.setDinoImage(image: "chickenosaurusLeft0" )
            }
            else if name.name == "stegosaurus" {
                print(name)
                self.setDinoImage(image: "stegosaurusLeft0" )
            }
            else if name.name == "triceratops" {
                print(name)
                self.setDinoImage(image: "triceratopsLeft0" )
            }
            else if name.name == "other" {
                #warning("mudar o nome")
                print(name)
                self.setDinoImage(image: "t-RexLeft0" )
            }
            
            self.selectedDino = name
            
            if name.isBought {
                self.isBought = "purchasedButton"
            }
            else {
                self.isBought = "buyButton"
            }
            
            if !name.isSelected {
                self.isSelected = "selectButton"
            }
            
            else{
                self.isSelected = "selectedButton"
            }
            
        }
        
        
        if !isBought{
            dinoButton.texture = SKTexture(imageNamed: (name.image ?? "frameTrex")+"Off")
        }
        
        if isSelected{
            dinoButton.texture = SKTexture(imageNamed: (name.image ?? "frameTrex")+"BuySelected")
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
        let plot = [[self.vetor[5],self.vetor[4],self.vetor[2]],[self.vetor[0],self.vetor[1],self.vetor[3]]]
        for i in 0..<3{
            for j in 0..<2{
                let button = createDino(name: plot[j][i], posX: i, posY: j,isBought: plot[j][i].isBought,isSelected: plot[j][i].isSelected)
                gallery.addChild(button)
            }
        }
        
        
        return gallery
    }
    
    
    override func didChangeSize(_ oldSize: CGSize) {
        super.didChangeSize(oldSize)
        
        setUpScene()
    }
    
    override func update(_ currentTime: TimeInterval) {
//        self.gallery.removeFromParent()
//        self.gallery = createGallery()
//        addChild(gallery)
        
        
    }
   
    
}
