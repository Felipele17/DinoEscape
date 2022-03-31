//
//  File.swift
//  DinoEscape
//
//  Created by Beatriz Duque on 15/03/22.
//

import Foundation
import SpriteKit


class Items: SKSpriteNode{
    var vy: Int
    var vx: Int
    var direction: GameCommand
    
    init(image: String, vy: Int, vx: Int, direction: GameCommand = .NONE){
        self.vy = vy
        self.vx = vx
        self.direction = direction
        super.init(texture: SKTexture(imageNamed: image), color: .clear, size: CGSize(width: 20, height: 20))
    }
    
    required init?(coder aDecoder: NSCoder) {
        queuedFatalError("init(coder:) has not been implemented")
    }
}
