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
    
    func setUpScene(){
        //adicionar e remover itens na tela
        scene.removeAllChildren()
        scene.removeAllActions()
        
        background.position = CGPoint(x:scene.size.width/2, y: scene.size.height/2)
        background.size = scene.frame.size
        background.zPosition = -5
        scene.addChild(background)


        let player = GameController.shared.gameData.player!
        playerNode = draw(player: player)
        drawAnalogic()
    
    }
    
    // desenhando o personagem na tela
    @discardableResult
    func draw(player: Player) -> SKSpriteNode{
//        let node = SKShapeNode(circleOfRadius: player.size.width)
//        node.position = player.position
//        node.fillColor = player.color
//        node.name = player.name
        
        let node = SKSpriteNode(imageNamed: "dinoTeste")
        node.position = player.position
        node.name = player.name
        node.setScale(0.05)
        scene.addChild(node)
    
        return node
    }
    
    func drawAnalogic() {
        scene.addChild(GameController.shared.joystickController.virtualController)
        
    }
    
    func update(_ currentTime: TimeInterval) {
        
        playerNode.position = GameController.shared.gameData.player!.position
    }
}
