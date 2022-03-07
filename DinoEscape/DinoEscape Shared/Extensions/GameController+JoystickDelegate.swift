//
//  GameController+JoystickDelegate.swift
//  DinoEscape iOS
//
//  Created by Beatriz Duque on 07/03/22.
//

import Foundation


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
           print("up")
        case .DOWN:
            print("down")
        case .RIGHT:
            print("right")
        case .LEFT:
            print("left")
        case .NONE:
            print("none")
        case .DEAD:
            print("dead")
            return
        }
    }
    
    func buttonReleased(command: GameCommand) {
        print("Released: \(command)")
        switch command {
        case .UP:
           print("up")
        case .DOWN:
            print("down")
        case .RIGHT:
            print("right")
        case .LEFT:
            print("left")
        case .NONE:
            print("none")
        case .DEAD:
            print("dead")
            return
        }
    }
    
    func joystickUpdate(_ currentTime: TimeInterval) {
        if let gamePadLeft = joystickController.gamePadLeft {
            if gamePadLeft.xAxis.value != 0 || gamePadLeft.xAxis.value != 0{
                let dx: CGFloat = CGFloat(gamePadLeft.xAxis.value)
                let dy: CGFloat = CGFloat(gamePadLeft.yAxis.value)
                
               //chamar funcao que atualiza o movimento
            }
        }
    }
    
    
}
