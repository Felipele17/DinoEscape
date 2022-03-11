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

        let sqquare = SKShapeNode(rectOf: CGSize(width: scene.size.width * 0.87, height: scene.size.height * 0.72))

        let player = GameController.shared.gameData.player!
        playerNode = draw(player: player)
        
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
        
        let node = SKSpriteNode(imageNamed: "dinoRosaRight")
        node.position = player.position
        node.name = player.name
        //playerNode.size = CGSize(width: scene.size.width*0.05, height: scene.size.height*0.05)
        node.setScale(scene.size.height*0.00005)
        scene.addChild(node)
    
        return node
    }
    
    func redraw(player: Player, texture: String) -> SKSpriteNode {
        
        let node = SKSpriteNode(imageNamed: texture)
        node.position = player.position
        node.name = player.name
        node.setScale(scene.size.height*0.00005)
        scene.addChild(node)
        playerNode.removeFromParent()
        return node
        
    }
    
    func selectDinoCommand(command: GameCommand) -> String {
        let height = scene.size.height
        switch command{
        case .UP:
            return "dinoRosaCostas"
        case .NONE:
            return "dinoRosa"
        case .RIGHT:
            return "dinoRosaRight"
        case .DOWN:
            return "dinoRosaFrente"
        case .LEFT:
            return  "dinoRosaLeft"
        case .DEAD:
            return "dinoRosaRight"
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
            playerNode = redraw(player: player, texture: selectDinoCommand(command: player.gameCommand))
            
        }
       
    }
}
