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
    var playerNode: SKShapeNode = SKShapeNode()
    
    func setUpScene(){
        //adicionar e remover itens na tela
        scene.removeAllChildren()
        scene.removeAllActions()
        
        let player = GameController.shared.gameData.player!
        playerNode = draw(player: player)
    }
    
    // desenhando o personagem na tela
    @discardableResult
    func draw(player: Player) -> SKShapeNode{
        let node = SKShapeNode(circleOfRadius: player.size.width)
        node.position = player.position
        node.fillColor = player.color
        node.name = player.name
        scene.addChild(node)
        return node
    }
    
    func update(_ currentTime: TimeInterval) {
        playerNode.position = GameController.shared.gameData.player!.position
    }
}
