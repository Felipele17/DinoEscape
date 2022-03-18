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
    
    var scene: MyScene = MyScene()
    var playerNode: SKSpriteNode = SKSpriteNode()
    var background: SKSpriteNode = SKSpriteNode(imageNamed: Backgrounds.shared.redBackground())
    var hitBoxNode: SKShapeNode = SKShapeNode()
    var pointsLabel: SKLabelNode = SKLabelNode(text: "0")
    var heartImage: SKSpriteNode = SKSpriteNode(imageNamed: "Heart")
    var lifesLabel: SKLabelNode = SKLabelNode(text: "3")
    var foodNodes: [SKSpriteNode] = [SKSpriteNode(imageNamed: "cherry"), SKSpriteNode(imageNamed: "cherry"), SKSpriteNode(imageNamed: "cherry"), SKSpriteNode(imageNamed: "cherry"), SKSpriteNode(imageNamed: "cherry")]
    
    func setUpScene(){
       
        
        //adicionar e remover itens na tela
        scene.removeAllChildren()
        scene.removeAllActions()
        
        background.position = CGPoint(x:scene.size.width/2, y: scene.size.height/2)
        background.size = scene.frame.size
        background.zPosition = -5
        scene.addChild(background)
        
        //SKLabel
        pointsLabel.position = CGPoint(x: scene.size.width/2, y: scene.size.height*0.91)
        scene.addChild(pointsLabel)
        
        //coracao
        heartImage.position = CGPoint(x: scene.size.width*0.82, y: scene.size.height*0.97)
        heartImage.setScale(0.5)
        scene.addChild(heartImage)
        
        //lifeslabel
        lifesLabel.position = CGPoint(x: heartImage.position.x*1.1, y: heartImage.position.y*0.985)
        scene.addChild(lifesLabel)
        
        
        // foodBar
        for i in foodNodes { scene.addChild(i) }
        drawFoodBar(food: GameController.shared.gameData.player?.foodBar ?? 10, foodNodes: foodNodes)
        
        
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
        let node = SKSpriteNode(imageNamed: "rexRight")
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
    
    func drawFoodBar(food: CGFloat, foodNodes: [SKSpriteNode]) {
        let foodMultiplier: Int = Int(food / 2) - 1
        for i in 0..<5 {
            if i <= foodMultiplier {
                foodNodes[i].texture = SKTexture(imageNamed: "cherry")
            } else {
                foodNodes[i].texture = SKTexture(imageNamed: "grayCherry")

            }
        }
        
        for i in 0..<foodNodes.count {
            
            foodNodes[i].setScale(0.35)
            if i == 0 {
                foodNodes[i].position = CGPoint(x: scene.size.width/2 * 0.665, y: pointsLabel.position.y*0.97)
            } else {
                foodNodes[i].position = CGPoint(x: foodNodes[0].position.x * (1 + CGFloat(i)/4), y: foodNodes[0].position.y)
            }
        }
    }
    
    func drawItem(item: Items){
        //item.node.name = "good"
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
            rect.physicsBody?.affectedByGravity = false
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
    func selectDinoCommand(command: GameCommand) -> String {
        // Quando o Dino fica na vertical hitbox é dividida por 3
        switch command{
        case .UP:
            return "rexUp"
        case .NONE:
            return "rexUp"
        case .RIGHT:
            return "rexRight"
        case .DOWN:
            return "rexDown"
        case .LEFT:
            return  "rexLeft"
        case .DEAD:
            return "rexRight"
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
            playerNode.texture = SKTexture(imageNamed: selectDinoCommand(command: player.gameCommand))
            lifesLabel.text = "\(player.life)"
        }
        
        for item in items {
            item.position.x += CGFloat(item.vx)
            item.position.y += CGFloat(item.vy)
            
        }
    }
    
    // MARK: Funcoes que mexem na velocidade dos itens
    func allFoodRender(){
        for i in items {
            if i.name != "good" {
                i.name = "good"
                i.texture = SKTexture(imageNamed: "cherry")
            }
        }
    }
    
    func slowRender(){
        for i in self.items {
            i.vx = i.vx * / 2
            i.vy = i.vy * / 2
        }
    }
}
