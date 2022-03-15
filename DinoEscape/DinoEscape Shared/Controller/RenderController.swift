//
//  RenderController.swift
//  DinoEscape iOS
//
//  Created by Beatriz Duque on 07/03/22.
//

import Foundation
import SpriteKit

class MyScene: SKScene, SKPhysicsContactDelegate{
    // MARK: Colisão
    func colisionBetween(dino: SKNode, object: SKNode){
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        print("oiii")
        guard let nodeA = contact.bodyA.node else {return}
        guard let nodeB = contact.bodyB.node else {return}
        
        print(nodeA)
        print(nodeB)
    }
}

class RenderController {
    
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
        
        
        let box = SKSpriteNode(imageNamed: "cherry")
        box.position = CGPoint(x: 200, y: 200)
        scene.addChild(box)
        box.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 100, height: 100))
        box.name = "box"
        box.physicsBody?.isDynamic = false
    


        
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
        node.size = CGSize(width: scene.size.height*0.05, height: scene.size.height*0.05)
        node.name = "dinossauro"
        node.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: node.size.width * 0.3, height: player.size.height * 0.3))
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
    
    
    func createGoodItems(){
        
        let directions: [GameCommand] = [.LEFT, .RIGHT, .UP, .DOWN]
        let direction = directions[Int.random(in: 0..<directions.count)]
        let item = Items(image: "cherry", vy: 0, vx: 0, direction: direction)
        item.node.name = "good"
        
        var xInitial: CGFloat = 0
        var yInitial: CGFloat = 0
        switch direction {
        case .UP:
            xInitial = CGFloat.random(in: scene.size.width * 0.06...scene.size.width * 0.94)
            yInitial = scene.size.height*1.1
        case .DOWN:
            xInitial = 0
        case .NONE:
            xInitial = 0

        case .RIGHT:
            xInitial = 0

        case .LEFT:
            xInitial = 0

        case .DEAD:
            xInitial = 0

        }
        //if x = Int.random(in: <#T##Range<Int>#>)
        //if y = Int.random(in: <#T##ClosedRange<Int>#>)
    }
    
    func createBadItems(){
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
            //print(selectDinoCommand(command: player.gameCommand))
            playerNode.texture = SKTexture(imageNamed: selectDinoCommand(command: player.gameCommand))
            print("position",playerNode.position)
            pointsLabel.text = "\(player.points)"
            lifesLabel.text = "\(player.life)"
            drawFoodBar(food: player.foodBar, foodNodes: foodNodes)
        }
        
        
       
    }
}
