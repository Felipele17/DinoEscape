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
    var coins: Int = GameController.shared.gameData.player?.dinoCoins ?? 10000
    var dinoChoosed: String = "T-Rex"
    var dinoImage = SKSpriteNode()
    var buyButton = SKButton()
    var selectButton = SKButton()
    var gallery = SKSpriteNode()
    var selectedDino = SkinData()
    
    var isBought: String = "purchasedButton"
    
    var isSelected: String = "selectedButton"
    
    
    class func newGameScene() -> StoreScene {
        let scene = StoreScene()
        scene.scaleMode = .resizeFill
        return scene
    }
    
    
    func setUpScene() {
        self.isUserInteractionEnabled = true
        
        backgroundColor = SKColor(red: 235/255, green: 231/255, blue: 198/255, alpha: 1)
//        MusicService.shared.playLondgeMusic()
        MusicService.shared.playGameMusic()
        
        
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
#if os(iOS) || os(tvOS)
        self.buyButton = createShopButtons(image: self.isBought, pos: 0)
        self.selectButton = createShopButtons(image: self.isSelected, pos: 1)
#elseif os(macOS)
        self.buyButton = createShopButtons(image: self.isBought, pos: 1)
        self.selectButton = createShopButtons(image: self.isSelected, pos: 0)
#endif
        addChild(self.selectButton)
        addChild(buyButton)
        
    }
    
    
    
    func setDinoImage(image: String) {

#if os(iOS) || os(tvOS)
        let square: SKShapeNode = SKShapeNode(rect: CGRect(
            x: size.width/6,
            y: size.height/4.6,
            width: size.width/1.5,
            height: size.height/3))
        square.lineWidth = 10
        square.strokeColor = SKColor(red: 100, green: 100, blue: 100, alpha: 1)
        
        addChild(square)
        
        dinoImage.position = CGPoint(x: size.width/2, y: size.width/1.1)
        dinoImage.size = CGSize(width: size.width/1.5, height: size.height/3)
        
#elseif os(macOS)
        let square: SKShapeNode = SKShapeNode(rect: CGRect(
            x: size.width/2.3,
            y: size.height/12.2,
            width: size.width/2.5,
            height: size.height/1.8))
        square.lineWidth = 10
        square.strokeColor = SKColor(red: 100, green: 100, blue: 100, alpha: 1)
        
        addChild(square)
        
        dinoImage.position = CGPoint(x: size.width/1.58, y: size.width/4.5)
        dinoImage.size = CGSize(width: size.width/2.7, height: size.height/1.7)
#endif
        
        dinoImage.texture = SKTexture(imageNamed: image)
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
    
    func createShopButtons(image: String, pos: Int) -> SKButton {
        let texture: SKTexture = SKTexture(imageNamed:image)
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
                x: buyButton.frame.width / 1.1 + CGFloat(pos) * buyButton.frame.width * 1.2,
                y: size.height / 6 )
        case .pad:
            buyButton.position = CGPoint(
                x: buyButton.frame.width / 1.1 + CGFloat(pos) * buyButton.frame.width * 1.2,
                y: size.height / 7 )
        default:
            print("default")
        }
        
#elseif os(macOS)
        buyButton.position = CGPoint(
            x: frame.width / 3,
            y: buyButton.frame.width / 2 + CGFloat(pos) * buyButton.frame.width * 0.5 )
        
#endif
        
        buyButton.selectedHandler = { [self] in
            self.buyButton.removeFromParent()
            self.selectButton.removeFromParent()
            
            if image == "selectedButton" {
                print("selecionado")
            } else if image == "selectButton" {
                _ = try! SkinDataModel.selectSkin(skin: self.selectedDino)
                //GameController.shared.gameData.skinSelected = try! SkinDataModel.getSkinSelected().name ?? "notFound"
                self.isSelected = "selectedButton"
                self.gallery = self.createGallery()
                self.addChild(self.gallery)
            } else if image == "buyButton" {
                if buyDino() == true {
                    _ = try! SkinDataModel.buyDino(skin: self.selectedDino)
                    self.isBought = "purchasedButton"
                    
                    self.gallery = self.createGallery()
                    self.addChild(self.gallery)
                }
            } else {
                print("comprado")
            }
            
            self.buyButton = self.createShopButtons(image: self.isBought, pos: 0)
            self.addChild(self.buyButton)
            
            self.selectButton = self.createShopButtons(image: self.isSelected, pos: 1)
            self.addChild(self.selectButton)
            
        }
        
        return buyButton
        
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
            y: size.height / 1.15 )
        
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
    
    
    func createDino(name: SkinData, posX: Int, posY: Int) -> SKButton {
        let texture: SKTexture = SKTexture(imageNamed: name.image ?? "frameTrex")
        texture.filteringMode = .nearest
        
        var buyImage: String = ""
        var selectImage: String = ""
        
        let w: CGFloat = size.width / 4.8
        let h = w * texture.size().height / texture.size().width
        
        let dinoButton: SKButton = SKButton(texture: texture, color: .clear, size: CGSize(width: w, height: h))
        
        
        if !name.isBought{
            dinoButton.texture = SKTexture(imageNamed: (name.image ?? "frameTrex")+"Off")
        }
        
        if name.isSelected{
            dinoButton.texture = SKTexture(imageNamed: (name.image ?? "frameTrex")+"BuySelected")
        }
        
        dinoButton.position = CGPoint(
            x: dinoButton.frame.width / 0.77 + CGFloat(posX) * dinoButton.frame.width * 1.1,
            y: size.height / 1.6 + CGFloat(posY) * dinoButton.frame.height * 1.2 )
        
        
        dinoButton.selectedHandler = { [self] in
            self.selectButton.removeFromParent()
            self.buyButton.removeFromParent()
            
            if name.isBought{
                self.isBought = "purchasedButton"
            }else {
                self.isBought = "buyButton"
            }
            
            if !name.isSelected {
                self.isSelected = "selectButton"
            }else{
                self.isSelected = "selectedButton"
            }
            
            self.buyButton = self.createShopButtons(image: self.isBought, pos: 0)
            self.addChild(buyButton)
            
            
            if name.isBought {
                self.selectButton = self.createShopButtons(image: self.isSelected, pos: 1)
                self.addChild(selectButton)
            }
            
            
            self.setDinoImage(image: name.name! + "Left0" )
            self.selectedDino = name
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
    
    
    func createGallery() -> SKSpriteNode {
        self.gallery.removeFromParent()
#if os(iOS) || os(tvOS)
        let gallery = SKSpriteNode(color: .clear, size: CGSize(width: size.width, height: size.height))
#elseif os(macOS)
        let gallery = SKSpriteNode(color: .clear, size: CGSize(width: size.width/2, height: size.height/2))
        gallery.position = CGPoint(x: size.width/14, y: size.height/2.35)
        gallery.setScale(0.5)
#endif
        
        let plot = [[self.vetor[5],self.vetor[4],self.vetor[2]],[self.vetor[0],self.vetor[1],self.vetor[3]]]
        let plotMacOS = [self.vetor[5],self.vetor[4],self.vetor[2],self.vetor[0],self.vetor[1],self.vetor[3]]


#if os(iOS) || os(tvOS)
        for i in 0..<3{
            for j in 0..<2{
                let button = createDino(name: plot[j][i], posX: i, posY: j)
                gallery.addChild(button)
            }
        }
#elseif os(macOS)
        for i in 0..<6{
                let button = createDino(name: plotMacOS[i], posX: i, posY: 0)
                gallery.addChild(button)
            
        }
        
#endif
        
        
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
    
    func buyDino()-> Bool{
        if self.coins >= Int(self.selectedDino.price){
            return true
        }
        return false
    }
    
    
}
