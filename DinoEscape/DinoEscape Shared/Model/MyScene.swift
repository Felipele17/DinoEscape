//
//  MyScene.swift
//  DinoEscape
//
//  Created by Luca Hummel on 16/03/22.
//

import Foundation
import SpriteKit

class MyScene: SKScene, SKPhysicsContactDelegate {
    // MARK: Colisão
    
    func didBegin(_ contact: SKPhysicsContact) {
        guard let nodeA = contact.bodyA.node else { return }
        guard let nodeB = contact.bodyB.node else { return }
                
        checkDestroier(nodeA: nodeA, nodeB: nodeB)
        checkDinoContact(nodeA: nodeA, nodeB: nodeB)
    }
    
    func checkDestroier(nodeA: SKNode, nodeB: SKNode) {
        if nodeA.name == "rect" {
            nodeB.removeFromParent()
        } else if nodeB.name == "rect" {
            nodeA.removeFromParent()
        }
    }
    
    func checkDinoContact(nodeA: SKNode, nodeB: SKNode) {
        if nodeA.name == "dinossauro" {
            if nodeB.name == "good" {
                feedDino()
            } else if nodeB.name == "bad" {
                hungryDino()
            } else if nodeB.name == "meteoro" {
                meteorDino()
            }
            nodeB.removeFromParent()
            // GameController.shared.renderer.items.remove(at: GameController.shared.renderer.items.firstIndex(of: nodeA as! Items)!)
        } else if nodeB.name == "dinossauro" {
            if nodeA.name == "good" {
                feedDino()
            } else if nodeA.name == "bad" {
                hungryDino()
            } else if nodeA.name == "meteoro" {
                meteorDino()
            }
            nodeA.removeFromParent()
            // GameController.shared.renderer.items.remove(at: GameController.shared.renderer.items.firstIndex(of: nodeA as! Items)!)
        }
    }
    
    func feedDino() {
        GameController.shared.gameData.score += GameController.shared.gameData.addPoints
        let points = GameController.shared.gameData.score
        
        if let player = GameController.shared.gameData.player {
            GameController.shared.nextLevel(points: points )
            if player.foodBar < 8 {
                player.foodBar += 0.5
            } else {
                let powerUp = GameController.shared.getPowerUp()
                print("PowerUp", GameController.shared.powerUpLogic(powerUp: powerUp))
                HapticService.shared.addVibration(haptic: "Haptic")
                player.foodBar = 6
            }
            GameController.shared.renderer.drawFoodBar(food: player.foodBar)
        }
    }
    
    func hungryDino() {
        if let player = GameController.shared.gameData.player {
            if player.foodBar > 4 {
                player.foodBar -= 1
            }
            GameController.shared.renderer.drawFoodBar(food: player.foodBar)
        }
    }
    
    func meteorDino() {
        HapticService.shared.addVibration(haptic: "Haptic2")
        if let player = GameController.shared.gameData.player {
            player.life -= 1
            if player.life <= 0 {
                player.gameCommand = .DEAD
                GameController.shared.gameData.gameStatus = .end
                if player.points < GameController.shared.gameData.score {
                    let score = GameController.shared.gameData.score
                    #if os(iOS) || os(tvOS)
                    GameCenterController.shared.sendScoreToGameCenter(score: score)
                    #endif
                    UserDefaults().set(score, forKey: "HighScore")
                    
                }
                
                let dinoCoins = GameController.shared.gameData.score / 10 + player.dinoCoins
                UserDefaults().set(dinoCoins, forKey: "DinoCoins")
                GameController.shared.gameData.player?.dinoCoins = dinoCoins
                self.view?.presentScene(GameOverScene.newGameScene())
                GameController.shared.restartGame()
            }
        }
    }
}
