//
//  GameController+JoystickDelegate.swift
//  DinoEscape iOS
//
//  Created by Beatriz Duque on 07/03/22.
//

import Foundation
import GameController

extension GameController: JoystickDelegate{
    func controllerDidConnect(controller: GCController) {
        print("Controller Connected")
    }
    
    func controllerDidDisconnect() {
        print("Controller Disconnected")
    }
    
    func keyboardDidConnect(keyboard: GCKeyboard) {
        print("Controller Connected")
    }
    
    func keyboardDidDisconnect(keyboard: GCKeyboard) {
        print("Controller Disconnected")
    }
    
    func buttonPressed(command: GameCommand) {
        print("pressed: \(command)")
        switch command {
        case .UP:
            gameData.player?.dinoVy = 1
        case .DOWN:
            gameData.player?.dinoVy = -1
        case .RIGHT:
            gameData.player?.dinoVx = 1
        case .LEFT:
            gameData.player?.dinoVx = -1
        case .NONE:
            gameData.player?.dinoVy = 0
            gameData.player?.dinoVx = 0
        case .DEAD:
            gameData.player?.dinoVy = 0
            gameData.player?.dinoVx = 0
            return
        }
    }
    
    func buttonReleased(command: GameCommand) {
        print("Released: \(command)")
        switch command {
        case .UP:
            gameData.player?.dinoVy = 0
        case .DOWN:
            gameData.player?.dinoVy = 0
        case .RIGHT:
            gameData.player?.dinoVx = 0
        case .LEFT:
            gameData.player?.dinoVx = 0
        case .NONE:
            gameData.player?.dinoVy = 0
            gameData.player?.dinoVx = 0
        case .DEAD:
            gameData.player?.dinoVy = 0
            gameData.player?.dinoVx = 0
            return
        }
    }
    
#warning("Função que pode ser descartada")
    func joystickUpdate(_ currentTime: TimeInterval) {
        
        //joystickController.virtualController?.changeState()
        let point = joystickController.virtualController.getVelocity()
        
        let dx: CGFloat = point.dx ?? 0
        let dy: CGFloat = point.dy ?? 0
        
        //joystickController.virtualController?.updateVector(for: CGPoint(x: dx, y: dy))
        
        movePlayer(dx: dx, dy: dy)
        
        
    }
    
    
}
