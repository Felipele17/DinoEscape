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
    var item: Items?
    
    var scene: MyScene = MyScene()
    var playerNode: SKSpriteNode = SKSpriteNode()
    var background: SKSpriteNode = SKSpriteNode(imageNamed: "coverTeste")
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
        drawFoodBar(food: 0.8, foodNodes: foodNodes)
        
        
        //player
        let player = GameController.shared.gameData.player!
        playerNode = draw(player: player)
        

        
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
        item.node.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: item.node.size.height*0.5, height: item.node.size.height*0.5))
        item.node.physicsBody?.isDynamic = false
        
        scene.addChild(item.node)
        items.append(item)
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
    
    // MARK: Desenho do controle
    #if os( iOS )
    func drawAnalogic() {
        scene.addChild(GameController.shared.joystickController.virtualController)
        
    }
    #endif

    
    // MARK: Update
    func update(_ currentTime: TimeInterval) {
        playerNode.position = GameController.shared.gameData.player!.position
        if let player = GameController.shared.gameData.player {
            playerNode.texture = SKTexture(imageNamed: selectDinoCommand(command: player.gameCommand))
            pointsLabel.text = "\(player.points)"
            lifesLabel.text = "\(player.life)"
            drawFoodBar(food: player.foodBar, foodNodes: foodNodes)
        }
        
        for item in items {
            item.node.position.x += CGFloat(item.vx)
            item.node.position.y += CGFloat(item.vy)
            
        }
        
       
    }
    
}
