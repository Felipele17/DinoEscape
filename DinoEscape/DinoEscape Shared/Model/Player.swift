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
    
    var life: Int
    var points: Int = UserDefaults().integer(forKey: "HighScore")
    var dinoCoins: Int = UserDefaults().integer(forKey: "DinoCoins")
    var foodBar: CGFloat
    var gameCommand: GameCommand 
    var powerUp: PowerUp?
    
    // variaveis de velocidade
    var dinoVy: CGFloat = 0.0
    var dinoVx: CGFloat = 0.0
    
    init(name: String, color: SKColor, position: CGPoint, size: CGSize, life: Int = 3, foodBar: CGFloat = 6.0, gameCommand: GameCommand, powerUp: PowerUp = .none ) {
        self.name = name
        self.color = color
        self.position = position
        self.size = size
        self.life = life
        self.foodBar = foodBar
        self.gameCommand = gameCommand
        
    }

}
