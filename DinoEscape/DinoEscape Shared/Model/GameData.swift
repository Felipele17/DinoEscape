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
    var addPoints: Int = 20
    var velocidadeGlobal: Int = 3
    var gameStatus: GameStatus = .notStarted
    var skinSelected = "t-rex"
    
    init(player: Player) {
        self.player = player
    }
    
    func restartGameData() {
        score = 0
        addPoints = 20
        velocidadeGlobal = 3
        gameStatus = .notStarted
        skinSelected = "t-rex"
    }
}
