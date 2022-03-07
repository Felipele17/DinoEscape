//
//  Player.swift
//  DinoEscape iOS
//
//  Created by Beatriz Duque on 07/03/22.
//

import Foundation
import SpriteKit

class Player: CustomStringConvertible {
    lazy var description: String = {
        return "Player { name:\(name), color: \(color) }"
    }()
    
    var name: String
    var color: SKColor
    var position: CGPoint
    var size: CGSize
    
    var skin: Skin
    var life: Int
    var points: Int
    var foodBar: Float
    var gameCommand: GameCommand 
    var powerUp: PowerUp?
    
    init(name: String, color: SKColor, position: CGPoint, size: CGSize, skin: Skin, life: Int = 3, points: Int = 0, foodBar: Float = 100, gameCommand: GameCommand, powerUp: PowerUp = .none ) {
        self.name = name
        self.color = color
        self.position = position
        self.size = size
        self.skin = skin
        self.life = life
        self.points = points
        self.foodBar = foodBar
        self.gameCommand = gameCommand
        
    }
}
