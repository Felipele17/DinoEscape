//
//  StoreScene.swift
//  DinoEscape macOS
//
//  Created by Carolina Ortega on 01/04/22.
//

import Foundation
import SpriteKit

class StoreScene: MyScene {
    let vetor = SkinDataModel.shared.getSkins()
    var coins: Int = GameController.shared.gameData.player?.dinoCoins ?? 10_000 {
        didSet {
            coinsLabel.text = "\(coins)"
        }
    }
    var dinoChoosed: String = "T-Rex"
    var dinoImage = SKSpriteNode()
    var buyButton = SKButton()
    var selectButton = SKButton()
    var gallery = SKSpriteNode()
    var reader = SKSpriteNode()
    lazy var selectedDino: SkinData = vetor[0]
    var coinsLabel = SKLabelNode()
    var priceLabel = SKLabelNode()
    var isBought: String = "purchasedButton"
    var isSelected: String = "selectedButton"
    
    class func newGameScene() -> StoreScene {
        let scene = StoreScene()
        scene.scaleMode = .resizeFill
        return scene
    }
    
    func setUpScene() {
        self.isUserInteractionEnabled = true

        backgroundColor = SKColor(red: 235 / 255, green: 231 / 255, blue: 198 / 255, alpha: 1)
        MusicService.shared.playGameMusic()
        removeAllChildren()
        removeAllActions()
        
        reader = createReader(coins: coins)
        addChild(reader)
        
        createSegButton(image: .eggs, pos: 0)
        createSegButton(image: .dinos, pos: 1)
        
        setDinoImage(image: "t-RexLeft0")
        
        addChild(dinoImage)
        
        let skins = SkinDataModel.shared.getSkins()
        if !skins.isEmpty {
            gallery = createGallery()
            addChild(gallery)
            
        }

        self.selectButton = createShopButtons(image: self.isSelected, pos: 0)
        addChild(self.selectButton)
        
    }

    func setDinoImage(image: String) {
        priceLabel.removeFromParent()
        
        let square: SKShapeNode = SKShapeNode(rect: CGRect(
            x: size.width / 2.3,
            y: size.height / 12.2,
            width: size.width / 2.5,
            height: size.height / 1.8))
        square.lineWidth = 10
        square.strokeColor = SKColor(red: 100, green: 100, blue: 100, alpha: 1)
        
        addChild(square)
        
        dinoImage.position = CGPoint(x: size.width / 1.58, y: size.width / 4.5)
        dinoImage.size = CGSize(width: size.width / 2.9, height: size.height / 1.9)
        
        priceLabel = SKLabelNode()
        if selectedDino.isBought == true {
            priceLabel.text = "Purchased".localized()
        } else {
            priceLabel.text = "$ \(selectedDino.price)"
        }
        
        priceLabel.fontName = "Aldrich-Regular"
        priceLabel.verticalAlignmentMode = .center
        priceLabel.horizontalAlignmentMode = .center
        priceLabel.color = .red
        priceLabel.fontSize = 60
        priceLabel.position = CGPoint(x: square.frame.width / 70, y: size.height / 4.5)

        priceLabel.numberOfLines = 1
        priceLabel.fontColor = SKColor(red: 221 / 255, green: 108 / 255, blue: 50 / 255, alpha: 1)
        dinoImage.texture = SKTexture(imageNamed: image)
        dinoImage.addChild(priceLabel)
    }
    
    func createShopButtons(image: String, pos: Int) -> SKButton {
        let texture: SKTexture = SKTexture(imageNamed: image)
        texture.filteringMode = .nearest
        
        var width: CGFloat = 0
        width = size.width / 7
        let height = width * texture.size().height / texture.size().width
        
        let buyButton: SKButton = SKButton(texture: texture, color: .clear, size: CGSize(width: width, height: height))
        buyButton.position = CGPoint(
            x: frame.width / 3,
            y: buyButton.frame.width / 2 + CGFloat(pos) * buyButton.frame.width * 0.5 )
        
        buyButton.selectedHandler = { [self] in
            self.buyButton.removeFromParent()
            self.selectButton.removeFromParent()
            
            if image == "selectedButton" {
                print("selecionado")
            } else if image == "selectButton" {
                SkinDataModel.shared.selectSkin(skin: self.selectedDino)
                self.isSelected = "selectedButton"
                self.gallery = self.createGallery()
                self.addChild(self.gallery)
            } else if image == "buyButton" {
                if buyDino() == true {
                    SkinDataModel.shared.buyDino(skin: self.selectedDino)
                    self.isBought = "purchasedButton"
                    
                    self.gallery = self.createGallery()
                    self.addChild(self.gallery)
                } else {
                }
            } else {
                print("comprado")
            }
            
            if self.isBought == "purchasedButton" {
                self.selectButton = self.createShopButtons(image: self.isSelected, pos: 1)
                self.addChild(self.selectButton)
            } else {
                self.buyButton = self.createShopButtons(image: self.isBought, pos: 0)
                self.addChild(self.buyButton)
            }
            
        }
        
        return buyButton
        
    }
    
    func createSegButton(image: SegmentageType, pos: Int) {
        let texture: SKTexture = SKTexture(imageNamed: "\(image.rawValue)")
        texture.filteringMode = .nearest
        var width: CGFloat = 0
        var height: CGFloat = 0
        
        width = size.width / 10
        height = width * texture.size().height / texture.size().width
          
        let segmentage: SKButton = SKButton(texture: texture, color: .blue, size: CGSize(width: width, height: height))
        
        segmentage.position = CGPoint(
            x: segmentage.frame.width / 0.228 + CGFloat(pos) * segmentage.frame.width * 1.24,
            y: size.height / 1.1 )
        
        segmentage.selectedHandler = {
            print(UserDefaults.standard.integer(forKey: "DinoCoins"))

            print("BOTAO APERTADO: \(pos)")
            switch image {
            case .eggs:
                self.view?.presentScene(EggScene.newGameScene())
            case .dinos:
                self.view?.presentScene(self)
            }
        }
        
        addChild(segmentage)
    }
    
    func createDino(name: SkinData, posX: Int, posY: Int) -> SKButton {
        let texture: SKTexture = SKTexture(imageNamed: name.image ?? "frameTrex")
        texture.filteringMode = .nearest
        
        let width: CGFloat = size.width / 4.8
        let height = width * texture.size().height / texture.size().width

        let dinoButton: SKButton = SKButton(texture: texture, color: .clear, size: CGSize(width: width, height: height))
    
        if !name.isBought {
            dinoButton.texture = SKTexture(imageNamed: (name.image ?? "frameTrex") + "Off")
        }
        
        if name.isSelected {
            dinoButton.texture = SKTexture(imageNamed: (name.image ?? "frameTrex") + "BuySelected")
        }

        dinoButton.position = CGPoint(
            x: dinoButton.frame.width / 0.77 + CGFloat(posX) * dinoButton.frame.width * 1.1,
            y: size.height / 1.6 + CGFloat(posY) * dinoButton.frame.height * 1.2 )

        dinoButton.selectedHandler = { [self] in
            self.selectButton.removeFromParent()
            self.buyButton.removeFromParent()
            
            if name.isBought {
                self.isBought = "purchasedButton"
            } else {
                self.isBought = "buyButton"
            }
            
            if !name.isSelected {
                self.isSelected = "selectButton"
            } else {
                self.isSelected = "selectedButton"
            }
            
            if name.isBought {
                self.selectButton = self.createShopButtons(image: self.isSelected, pos: 1)
                self.addChild(selectButton)
            } else {
                self.buyButton = self.createShopButtons(image: self.isBought, pos: 0)
                self.addChild(buyButton)
            }
            
            self.selectedDino = name
            self.setDinoImage(image: name.name! + "Left0" )
        }
        
        return dinoButton
        
    }
    
    func createReader(coins: Int) -> SKSpriteNode {
        let reader = SKSpriteNode(color: .clear, size: CGSize(width: size.width, height: size.height))
        
        reader.addChild(createTotalCoin(coins: coins))
//        reader.addChild(createADSButton(pos: 0))
        reader.addChild(createBackButton())
        return reader
    }

    func createTotalCoin(coins: Int) -> SKSpriteNode {
        let coinTotal = SKSpriteNode(color: .clear, size: CGSize(width: size.width, height: size.height) )
        
        let width = size.width / 20
        let height = width * coinTotal.size.height / coinTotal.size.width / 0.7
        
        let coin: SKSpriteNode = SKSpriteNode(imageNamed: "DinoCoin")
        coin.position = CGPoint(x: size.width / 1.1, y: size.height / 1.103)
        coin.size = CGSize(width: width, height: height)
        
        coinsLabel = SKLabelNode(text: String(coins))
        coinsLabel.fontName = "Aldrich-Regular"
        coinsLabel.horizontalAlignmentMode = .right

        coinsLabel.fontSize = 60
        coinsLabel.position = CGPoint(x: coin.position.x / 1.05, y: size.height / 1.125)
        coinsLabel.numberOfLines = 1
        coinsLabel.fontColor = SKColor(red: 221 / 255, green: 108 / 255, blue: 50 / 255, alpha: 1)
        
        addChild(coin)
        addChild(coinsLabel)
        return coinTotal
    }

    func createBackButton() -> SKButton {
        let texture = SKTexture(imageNamed: "backButton")
        texture.filteringMode = .nearest
        
        var width: CGFloat = 0
        var height: CGFloat = 0
        width = size.width / 20
        height = width * texture.size().height / texture.size().width
        let button: SKButton = SKButton(texture: texture, color: .clear, size: CGSize(width: width, height: height))
        button.position = CGPoint(x: size.width / 12, y: size.height / 1.103)
        button.selectedHandler = {
            self.view?.presentScene(HomeScene.newGameScene())
            
        }
        
        return button
    }
    
    func createGallery() -> SKSpriteNode {
        self.gallery.removeFromParent()
        let gallery = SKSpriteNode(color: .clear, size: CGSize(width: size.width, height: size.height))
        gallery.position = CGPoint(x: size.width / 14, y: size.height / 2.3)
        gallery.setScale(0.5)

        let plotMacOS = [self.vetor[5], self.vetor[4], self.vetor[2], self.vetor[0], self.vetor[1], self.vetor[3]]
        
        for xPos in 0..<6 {
            let button = createDino(name: plotMacOS[xPos], posX: xPos, posY: 0)
            gallery.addChild(button)
        }
        
        return gallery
    }

    override func didChangeSize(_ oldSize: CGSize) {
        super.didChangeSize(oldSize)
        print(self.size)
        setUpScene()
    }

    func buyDino() -> Bool {
        if self.coins >= Int(self.selectedDino.price) {
            self.coins -= Int(self.selectedDino.price)
            UserDefaults().set(self.coins, forKey: "DinoCoins")
            print(UserDefaults.standard.integer(forKey: "DinoCoins"))
            GameController.shared.gameData.player?.dinoCoins = self.coins

            reader.removeFromParent()
            addChild(reader)
            return true
        }
        return false
    }
}
