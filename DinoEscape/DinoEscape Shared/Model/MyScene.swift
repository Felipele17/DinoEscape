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
        
        checkDestroier(nodeA: nodeA, nodeB: nodeB)
        
        if (nodeA.name == "dinossauro" && nodeB.name == "good") {
            nodeB.removeFromParent()
            if let player = GameController.shared.gameData.player {
                player.points += 10
                if player.foodBar < 20 {
                    player.foodBar += 1
                }
                GameController.shared.renderer.drawFoodBar(food: player.foodBar, foodNodes: GameController.shared.renderer.foodNodes)
            }
            
            //GameController.shared.renderer.items.remove(at: items.firstIndex(of: nodeB.)!)
        } else if (nodeA.name == "good" && nodeB.name == "dinossauro") {
            nodeA.removeFromParent()
            if let player = GameController.shared.gameData.player {
                player.points += 10
                if player.foodBar < 20 {
                    player.foodBar += 1
                }
                GameController.shared.renderer.drawFoodBar(food: player.foodBar, foodNodes: GameController.shared.renderer.foodNodes)
            }
        } else if (nodeA.name == "dinossauro" && nodeB.name == "bad") {
            nodeB.removeFromParent()
            if let player = GameController.shared.gameData.player {
                //player.life -= 1
                if player.foodBar > 2 {
                    player.foodBar -= 2
                }
                GameController.shared.renderer.drawFoodBar(food: player.foodBar, foodNodes: GameController.shared.renderer.foodNodes)
            }
        } else if (nodeA.name == "bad" && nodeB.name == "dinossauro") {
            nodeA.removeFromParent()
            if let player = GameController.shared.gameData.player {
                if player.foodBar > 2 {
                    player.foodBar -= 2
                }
                GameController.shared.renderer.drawFoodBar(food: player.foodBar, foodNodes: GameController.shared.renderer.foodNodes)
            }
        }

    }
    
    func checkDestroier(nodeA: SKNode, nodeB: SKNode) {
        if (nodeA.name == "rect" && nodeB.name == "good") || (nodeA.name == "rect" && nodeB.name == "bad"){
            nodeB.removeFromParent()
            print("deleta")
        } else if (nodeA.name == "good" && nodeB.name == "rect") || (nodeA.name == "bad" && nodeB.name == "rect") {
            nodeA.removeFromParent()
            print("deleta")
        }
    }
}
