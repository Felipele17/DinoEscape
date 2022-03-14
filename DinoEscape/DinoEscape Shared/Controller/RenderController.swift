//
//  RenderController.swift
//  DinoEscape iOS
//
//  Created by Beatriz Duque on 07/03/22.
//

import Foundation
import SpriteKit

class RenderController {
    
    var scene: SKScene = SKScene()
    var playerNode: SKSpriteNode = SKSpriteNode()
    var background: SKSpriteNode = SKSpriteNode(imageNamed: "coverTeste")
    var hitBoxNode: SKShapeNode = SKShapeNode()
    
    func setUpScene(){
        //adicionar e remover itens na tela
        scene.removeAllChildren()
        scene.removeAllActions()
        
        background.position = CGPoint(x:scene.size.width/2, y: scene.size.height/2)
        background.size = scene.frame.size
        background.zPosition = -5
        scene.addChild(background)

        // Definicao do tamanho da hitBox
        hitBoxNode = SKShapeNode(rectOf: CGSize(width: scene.size.height*0.05, height: scene.size.height*0.035))
        hitBoxNode.lineWidth = 1
        
        let player = GameController.shared.gameData.player!
        playerNode = draw(player: player)
        playerNode.addChild(hitBoxNode)
        
        #if os( iOS)
        drawAnalogic()
        #endif
    
    }
    
    // desenhando o personagem na tela
    @discardableResult
    func draw(player: Player) -> SKSpriteNode{
//        let node = SKShapeNode(circleOfRadius: player.size.width)
//        node.position = player.position
//        node.fillColor = player.color
//        node.name = player.name
        
        let node = SKSpriteNode(imageNamed: "rexRight")
        node.position = player.position
        node.name = player.name
        node.size = CGSize(width: scene.size.height*0.05, height: scene.size.height*0.05)
        
        scene.addChild(node)
    
        return node
    }
    
    func selectDinoCommand(command: GameCommand) -> String {
        // Quando o Dino fica na vertical hitbox é dividida por 3
        switch command{
        case .UP:
            hitBoxNode.xScale = 0.3
            return "rexUp"
        case .NONE:
            return "rexUp"
        case .RIGHT:
            hitBoxNode.xScale = 1
            return "rexRight"
        case .DOWN:
            hitBoxNode.xScale = 0.3
            return "rexDown"
        case .LEFT:
            hitBoxNode.xScale = 1
            return  "rexLeft"
        case .DEAD:
            return "rexRight"
        }
    }
    
    #if os( iOS )
    func drawAnalogic() {
        scene.addChild(GameController.shared.joystickController.virtualController)
        
    }
    #endif
    
    func update(_ currentTime: TimeInterval) {
        playerNode.position = GameController.shared.gameData.player!.position
        if let player = GameController.shared.gameData.player {
            print(selectDinoCommand(command: player.gameCommand))
            playerNode.texture = SKTexture(imageNamed: selectDinoCommand(command: player.gameCommand))

        }
       
    }
}
