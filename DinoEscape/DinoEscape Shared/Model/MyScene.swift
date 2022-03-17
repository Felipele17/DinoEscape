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
    
    func didBegin(_ contact: SKPhysicsContact) {
        guard let nodeA = contact.bodyA.node else {return}
        guard let nodeB = contact.bodyB.node else {return}
                
        checkDestroier(nodeA: nodeA, nodeB: nodeB)
        
        checkDinoContact(nodeA: nodeA, nodeB: nodeB)
        
    }
    
    func checkDestroier(nodeA: SKNode, nodeB: SKNode) {
        if nodeA.name == "rect" {
            nodeB.removeFromParent()
        } else if nodeB.name == "rect" {
            nodeA.removeFromParent()
        }
    }
    
    func checkDinoContact(nodeA: SKNode, nodeB: SKNode){
        if nodeA.name == "dinossauro" {
            if nodeB.name == "good" {
                feedDino()
            } else if nodeB.name == "bad" {
                hungryDino()
            } else if nodeB.name == "meteoro" {
                meteorDino()
            }
            nodeB.removeFromParent()
            //GameController.shared.renderer.items.remove(at: GameController.shared.renderer.items.firstIndex(of: nodeA as! Items)!)
        } else if nodeB.name == "dinossauro" {
            if nodeA.name == "good" {
                feedDino()
            } else if nodeA.name == "bad" {
                hungryDino()
            } else if nodeA.name == "meteoro" {
                meteorDino()
            }
            nodeA.removeFromParent()
            //GameController.shared.renderer.items.remove(at: GameController.shared.renderer.items.firstIndex(of: nodeA as! Items)!)
        }
    }
    
    func feedDino(){
        if let player = GameController.shared.gameData.player {
            player.points += 10
            GameController.shared.nextLevel(points: player.points ?? 0)
            if player.foodBar < 20 {
                player.foodBar += 1
            }
            GameController.shared.renderer.drawFoodBar(food: player.foodBar, foodNodes: GameController.shared.renderer.foodNodes)
        }
    }
    
    func hungryDino(){
        if let player = GameController.shared.gameData.player {
            //player.life -= 1
            if player.foodBar > 2 {
                player.foodBar -= 2
            }
            GameController.shared.renderer.drawFoodBar(food: player.foodBar, foodNodes: GameController.shared.renderer.foodNodes)
        }
    }
    
    func meteorDino(){
        if let player = GameController.shared.gameData.player {
            player.life -= 1
            if player.life <= 0{
                player.gameCommand = .DEAD
            }
        }
    }
}

