//
//  GameController+JoystickDelegate.swift
//  DinoEscape iOS
//
//  Created by Beatriz Duque on 07/03/22.
//

import Foundation
import GameController

extension GameController: JoystickDelegate {
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
        case .PAUSE:
            pauseGame()
        case .PLAY:
            playGame()
        case .HOME:
            backToHome()
        case .TAP:
            pauseGame()
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
        case .PAUSE:
            return
        case .PLAY:
            return
        case .HOME:
            return
        case .TAP:
            return
        }
    }
    
    func joystickUpdate(_ currentTime: TimeInterval) {
        #if os( iOS )
        let point = joystickController.virtualController.getVelocity()
        
        let directionX: CGFloat = point.dx
        let directionY: CGFloat = point.dy
        movePlayer(directionX: directionX, directionY: directionY)
        
        #endif
        
        // TVOs que funciona com os gestos
        #if os(tvOS)
        if let gamePadLeft = joystickController.gamePadLeft {
            if gamePadLeft.xAxis.value != 0 || gamePadLeft.yAxis.value != 0 {
                let directionX: CGFloat = CGFloat(gamePadLeft.xAxis.value)
                let directionY: CGFloat = CGFloat(gamePadLeft.yAxis.value)
                movePlayer(directionX: directionX, directionY: directionY)
            }
        }
        #endif
    }
    
    func selectPlayerState(command: GameCommand) {
        // manda o comando selecionado para o player
        gameData.player?.gameCommand = command
    }
    
}
