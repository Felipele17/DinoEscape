//
//  RenderController.swift
//  DinoEscape iOS
//
//  Created by Beatriz Duque on 07/03/22.
//

import Foundation
import SpriteKit

class RenderController {
    
    // MARK: Array de itens
    var items: [Items] = []
    var itemCount: Int = 0
    
    // player
    var scene: MyScene = MyScene()
    var playerNode: SKSpriteNode = SKSpriteNode()
    var background: SKSpriteNode = SKSpriteNode(imageNamed: Backgrounds.shared.newBackground(background: "redBackground"))
    var hitBoxNode: SKShapeNode = SKShapeNode()
    
    // header da tela
    var pointsLabel: SKLabelNode = SKLabelNode(text: "0")
    var heartImage: SKSpriteNode = SKSpriteNode(imageNamed: "Heart")
    var lifesLabel: SKLabelNode = SKLabelNode(text: "3")
    var foodNodes: [SKSpriteNode] = [SKSpriteNode(imageNamed: "cherry"), SKSpriteNode(imageNamed: "cherry"), SKSpriteNode(imageNamed: "cherry"), SKSpriteNode(imageNamed: "cherry"), SKSpriteNode(imageNamed: "cherry")]
    
    // cena de pause
    var pauseScene = SettingsPopUpScene()
#if os(iOS)
    var pauseNode: SKButton = SKButton(imageNamed: "pause")
#endif
    
    var rectOut = SKShapeNode()
    let rectIn = SKSpriteNode()
    
    // contagem regressiva
    var contagemLabel: SKLabelNode = SKLabelNode()
    
    func setUpScene(){
        
        
        //adicionar e remover itens na tela
        scene.removeAllChildren()
        scene.removeAllActions()
        
        background.position = CGPoint(x:scene.size.width/2, y: scene.size.height/2)
        background.size = scene.frame.size
        background.zPosition = -5
        scene.addChild(background)
        
        //contador
        drawContador()
        
        //SKLabel
        pointsLabel.position = CGPoint(x: scene.size.width/2, y: scene.size.height*0.91)
        pointsLabel.fontName = "Aldrich-Regular"
        scene.addChild(pointsLabel)
        
        //coracao
#if os(iOS)
        heartImage.position = CGPoint(x: scene.size.width*0.82, y: scene.size.height*0.95)
        heartImage.setScale(0.5)
#elseif os(macOS) || os(tvOS)
        heartImage.position = CGPoint(x: scene.size.width*0.92, y: scene.size.height*0.95)
        heartImage.setScale(0.75)
#endif
        
        
        scene.addChild(heartImage)
        
        //lifeslabel
        lifesLabel.fontName = "Aldrich-Regular"
#if os(iOS)
        lifesLabel.position = CGPoint(x: heartImage.position.x*1.1, y: heartImage.position.y*0.985)
#elseif os(macOS) || os(tvOS)
        lifesLabel.position = CGPoint(x: heartImage.position.x*1.04, y: heartImage.position.y*0.985)
        lifesLabel.fontSize = 35
#endif
        scene.addChild(lifesLabel)
        
        
        // foodBar
        rectOut = SKShapeNode(rectOf: CGSize(width: scene.size.width * 0.5, height: scene.size.height * 0.03))
        rectOut.position = CGPoint(x: scene.size.width / 2, y: pointsLabel.position.y*0.96)
        rectOut.fillColor = .clear
        rectOut.lineWidth = 1
        rectOut.strokeColor = .black
        
        rectIn.size = CGSize(width: scene.size.width * 0.1, height: scene.size.height * 0.03)
        rectIn.color = .yellow.withAlphaComponent(0.5)
        
        drawFoodBar(food: GameController.shared.gameData.player?.foodBar ?? 6.0)
        
#if os(iOS)
        //pause node
        pauseNode.position = CGPoint(x: scene.size.width*0.1, y: scene.size.height*0.95)
        pauseNode.setScale(0.4)
        pauseNode.selectedHandler = {
            GameController.shared.pauseGame()
        }
        pauseNode.zPosition = 5
        scene.addChild(pauseNode)
#endif
        
        //player
        let player = GameController.shared.gameData.player!
        playerNode = draw(player: player)
        
        drawDestroierRects()
        
        
        
#if os( iOS)
        drawAnalogic()
#endif
        
        
    }
    
    // MARK: Desenho dos nós na tela
    
    @discardableResult
    func draw(player: Player) -> SKSpriteNode {
        let node = SKSpriteNode(imageNamed: GameController.shared.gameData.skinSelected+"Right0")
        node.position = player.position
        node.name = player.name
        node.size = CGSize(width: scene.size.height*0.1, height: scene.size.height*0.1)
        node.name = "dinossauro"
        node.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: node.size.width * 0.5, height: node.size.height * 0.5))
        node.physicsBody?.isDynamic = true
        node.physicsBody?.allowsRotation = false
        node.physicsBody?.affectedByGravity = false
        node.physicsBody?.contactTestBitMask = node.physicsBody!.collisionBitMask
        
        scene.addChild(node)
        
        return node
    }
    
    func drawFoodBar(food: CGFloat) {
        rectIn.removeFromParent()
        rectOut.removeFromParent()
        
        let foodMultiplier: Int = Int((Float(food / 4) - 1) * 5)
        
        rectIn.position = CGPoint(x: scene.size.width / 2, y: pointsLabel.position.y*0.96)
        
        rectIn.size.width = scene.size.width * 0.1 * CGFloat(foodMultiplier)
        
        scene.addChild(rectIn)
        scene.addChild(rectOut)
    }
    
    func drawItem(item: Items, x: CGFloat, y: CGFloat){
        var multiplier = 0.05
        if item.name == "meteoro" {
            multiplier = 0.08
            if item.direction == .LEFT {
                item.xScale = item.xScale * -1
            } else if item.direction == .DOWN {
                item.yScale = item.yScale * -1
            }
        }
        item.size = CGSize(width: scene.size.height*multiplier, height: scene.size.height*multiplier)
        item.position = CGPoint(x: x, y: y)
        
        item.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: item.size.height*0.5, height: item.size.height*0.5))
        item.physicsBody?.isDynamic = false
        
        
        
        scene.addChild(item)
        self.appendItems(item: item)
    }
    
    func drawDestroierRects() {
        
        for i in 0..<4 {
            let rect = SKSpriteNode(color: .red, size: CGSize(width: 20, height: 20))
            
            if i < 2 {
                rect.size = CGSize(width: scene.size.width, height: 20)
                rect.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: scene.size.width, height: 20))
                if i == 0 {
                    rect.position = CGPoint(x: scene.size.width/2, y: scene.size.height*1.2)
                } else {
                    rect.position = CGPoint(x: scene.size.width/2, y: scene.size.height * -0.2)
                }
            } else {
                rect.size = CGSize(width: 20, height: scene.size.height)
                rect.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 20, height: scene.size.height))
                if i == 2 {
                    rect.position = CGPoint(x: scene.size.width*1.2, y: scene.size.height/2)
                } else {
                    rect.position = CGPoint(x: scene.size.width * -0.2, y: scene.size.height/2)
                }
            }
            print(rect.position)
            rect.physicsBody?.affectedByGravity = false
            rect.physicsBody?.allowsRotation = false
            rect.physicsBody?.contactTestBitMask = rect.physicsBody!.collisionBitMask
            
            rect.name = "rect"
            scene.addChild(rect)
            
        }
    }
    
    // MARK: Contando itens
    func appendItems(item: Items){
        // definindo um contador de itens maximos na tela de 50
        if items.count < 50{
            items.append(item)
        }
        else{
            // quando chegar em 50, zera o contador
            items[itemCount] = item
            itemCount += 1
            if itemCount > 49 {
                itemCount = 0
            }
        }
    }
    
    // MARK: Desenho do dinossauro
    func selectDinoCommand(command: GameCommand, skin: String) -> String {
        // Quando o Dino fica na vertical hitbox é dividida por 3
        switch command{
        case .UP:
            return skin+"BackL"
        case .NONE:
            return skin+"Right0"
        case .RIGHT:
            return skin+"Right0"
        case .DOWN:
            return skin+"FrontL"
        case .LEFT:
            return  skin+"Left0"
        case .DEAD:
            return skin+"Right0"
        case .PAUSE:
            return skin+"Right0"
        case .PLAY:
            return skin+"Right0"
        case .HOME:
            return skin+"Right0"
        case .TAP:
            return skin+"Right0"
        }
    }
    
    // MARK: Desenhando background
    func changeBackground(named: String){
        background.texture = SKTexture(imageNamed: named)
    }
    
    // MARK: Desenho do controle
#if os( iOS )
    func drawAnalogic() {
        scene.addChild(GameController.shared.joystickController.virtualController)
        
    }
#endif
    
    
    // MARK: Update
    func update(_ currentTime: TimeInterval, gameData: GameData) {
        
        pointsLabel.text = "\(gameData.score)"
        
        playerNode.position = gameData.player!.position
        if let player = gameData.player {
            playerNode.texture = SKTexture(imageNamed: selectDinoCommand(command: player.gameCommand, skin: gameData.skinSelected))
            lifesLabel.text = "\(player.life)"
        }
        
        for item in items {
            item.position.x += CGFloat(item.vx)
            item.position.y += CGFloat(item.vy)
            
        }
    }
    
    func showPauseMenu() {
        pauseScene = SettingsPopUpScene(color: .clear, size: CGSize(width: scene.size.width/1.5, height: scene.size.height/2))
        pauseScene.position = CGPoint(x: scene.size.width/2, y: scene.size.height/2)
        pauseScene.zPosition = 10
        scene.addChild(pauseScene)
    }
    
    
    func showOnboard() {
        self.contagemLabel.removeFromParent()

        let onboard = OnboardScene(color: .clear, size: CGSize(width: scene.size.width/1.5, height: scene.size.height/2))
        onboard.position = CGPoint(x: scene.size.width/2, y: scene.size.height/2)
        onboard.zPosition = 10
        scene.addChild(onboard)
        
    }
    
    func restartGame() {
        changeBackground(named: Backgrounds.shared.newBackground(background: "redBackground"))
        drawFoodBar(food: GameController.shared.gameData.player?.foodBar ?? 6.0)
        pointsLabel.text = "\(GameController.shared.gameData.score)"
        lifesLabel.text = "\(GameController.shared.gameData.player?.life ?? 3)"
        
    }
    
    // MARK: Funcoes que mexem na velocidade dos itens
    func allFoodRender(){
        for i in items {
            if i.name != "good" {
                i.name = "good"
                i.texture = SKTexture(imageNamed: "cherry")
                i.size = CGSize(width: scene.size.height*0.05, height: scene.size.height*0.05)
            }
        }
    }
    
    func slowRender(){
        for i in self.items {
            if i.vx / 2 > 1 || i.vy / 2 > 1 {
                i.vx = i.vx / 2
                i.vy = i.vy / 2
            }
            
        }
    }
    
    func drawPowerUp(powerUp: PowerUp) -> SKLabelNode {
        let label = SKLabelNode()
        if powerUp == .slow {
            label.text = "SLOW".localized()
        }else if powerUp == .allFood {
            label.text = "FOOOOOD".localized()
        }else if powerUp == .doubleXP {
            label.text = "DOUBLE POINTS".localized()
        }
        
        label.fontName = "Aldrich-Regular"
        label.position = CGPoint(x: scene.size.width/2, y: scene.size.height/2)
        scene.addChild(label)
        return label
    }
    
    
    func drawNewEra() -> SKLabelNode {
        let label = SKLabelNode()
        
        label.text = "NEW ERA".localized()
        label.fontSize = 40
        label.fontName = "Aldrich-Regular"
        
        label.position = CGPoint(x: scene.size.width/2, y: scene.size.height/2 + 180)
        scene.addChild(label)
        return label
    }
    
    func excludeNode(label: SKLabelNode){
        label.removeFromParent()
    }
    
    func drawContador(){
        contagemLabel.text = "3"
        contagemLabel.fontName = "Aldrich-Regular"
        
        contagemLabel.position = CGPoint(x: scene.size.width/2, y: scene.size.height/2 + 50)
        scene.addChild(contagemLabel)
    }
    
}
