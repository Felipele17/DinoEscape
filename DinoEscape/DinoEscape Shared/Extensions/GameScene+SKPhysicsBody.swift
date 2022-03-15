//
//  GameController+SKPhysicsBody.swift
//  DinoEscape
//
//  Created by Beatriz Duque on 15/03/22.
//

import Foundation
import SpriteKit


extension GameScene: SKPhysicsContactDelegate{
    
    
    // MARK: Colisão
    func colisionBetween(dino: SKNode, object: SKNode){
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        guard let nodeA = contact.bodyA.node else {return}
        guard let nodeB = contact.bodyB.node else {return}
        
        print(nodeA)
        print(nodeB)
    }
}
