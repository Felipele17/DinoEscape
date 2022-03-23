//
//  GameCenterDelegate.swift
//  DinoEscape iOS
//
//  Created by Beatriz Duque on 07/03/22.
//

import Foundation

protocol GameCenterDelegate: AnyObject{
    func sendGameScore(score: Int)
}
