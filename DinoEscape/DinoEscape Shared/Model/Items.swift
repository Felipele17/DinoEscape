//
//  File.swift
//  DinoEscape
//
//  Created by Beatriz Duque on 15/03/22.
//

import Foundation
import SpriteKit

class Items: SKSpriteNode {
    var velocidadeY: Int
    var velocidadeX: Int
    var direction: GameCommand
    
    init(image: String, velocidadeY: Int, velocidadeX: Int, direction: GameCommand = .NONE) {
        self.velocidadeY = velocidadeY
        self.velocidadeX = velocidadeX
        self.direction = direction
        super.init(texture: SKTexture(imageNamed: image), color: .clear, size: CGSize(width: 20, height: 20))
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
