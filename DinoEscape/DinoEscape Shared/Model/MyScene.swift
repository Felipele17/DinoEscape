//
//  MyScene.swift
//  DinoEscape
//
//  Created by Luca Hummel on 16/03/22.
//

import Foundation
import SpriteKit

class MyScene: SKScene, SKPhysicsContactDelegate{
    // MARK: Colisão
    func colisionBetween(dino: SKNode, object: SKNode){
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        guard let nodeA = contact.bodyA.node else {return}
        guard let nodeB = contact.bodyB.node else {return}
        
        if (nodeA.name == "dinossauro" && nodeB.name == "good") {
            nodeB.removeFromParent()
            GameController.shared.gameData.player?.points += 10
            //GameController.shared.renderer.items.remove(at: items.firstIndex(of: nodeB.)!)
        } else if (nodeA.name == "good" && nodeB.name == "dinossauro") {
            nodeA.removeFromParent()
            GameController.shared.gameData.player?.points += 10
        } else if (nodeA.name == "dinossauro" && nodeB.name == "bad") {
            nodeB.removeFromParent()
            GameController.shared.gameData.player?.life -= 1
        } else if (nodeA.name == "bad" && nodeB.name == "dinossauro") {
            nodeA.removeFromParent()
            GameController.shared.gameData.player?.life -= 1
        }

    }
}
