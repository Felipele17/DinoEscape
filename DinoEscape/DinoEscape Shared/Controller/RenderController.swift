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
        
        drawAnalogic()
    
        //print(GameController.shared.joystickController.virtualController)
    }
    
    // desenhando o personagem na tela
    @discardableResult
    func draw(player: Player) -> SKShapeNode{
        let node = SKShapeNode(circleOfRadius: player.size.width)
        node.position = player.position
        node.fillColor = player.color
        node.name = player.name
        scene.addChild(node)
        
        //        let stick = AnalogStick(position: CGPoint(x: scene.size.width/2, y: scene.size.height/2))
        //        scene.addChild(stick.createStick(named: "stick"))
        
        return node
    }
    
    func drawAnalogic() {
        scene.addChild(GameController.shared.joystickController.virtualController)
        
    }
    
    func update(_ currentTime: TimeInterval) {
        
        playerNode.position = GameController.shared.gameData.player!.position
    }
}
