//
//  GameViewController+GameCenterDelegate.swift
//  DinoEscape iOS
//
//  Created by Luca Hummel on 22/03/22.
//

import Foundation

extension GameViewController: GameCenterDelegate {
    func sendGameScore(score: Int) {
        gController?.sendScoreToGameCenter(score: score)
    }
}
