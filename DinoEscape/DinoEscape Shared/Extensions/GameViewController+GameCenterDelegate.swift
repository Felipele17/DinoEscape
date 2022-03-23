//
//  GameViewController+GameCenterDelegate.swift
//  DinoEscape iOS
//
//  Created by Luca Hummel on 22/03/22.
//

import Foundation

extension GameViewController: UpdateGameCenterDelegate {
    func sendGameScore(score: Int) {
        let gController = GameCenterController(viewController: self)
        gController.sendScoreToGameCenter(score: score)
    }
}
