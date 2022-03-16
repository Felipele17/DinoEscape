//
//  File.swift
//  DinoEscape
//
//  Created by Beatriz Duque on 15/03/22.
//

import Foundation
import SpriteKit


class Items{
    var image: String
    var vy: Int
    var vx: Int
    var direction: GameCommand
    var node: SKSpriteNode
    
    init(image: String, vy: Int, vx: Int, direction: GameCommand){
        self.image = image
        self.vy = vy
        self.vx = vx
        self.direction = direction
        self.node = SKSpriteNode(imageNamed: image)
    }
}
