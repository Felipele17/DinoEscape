//
//  GameData.swift
//  DinoEscape iOS
//
//  Created by Beatriz Duque on 07/03/22.
//

import Foundation

class GameData {
    
    var player: Player?
    var score: Int = 0
    
    init(player: Player) {
        self.player = player
    }
}
