//
//  JoystickDelegate.swift
//  DinoEscape iOS
//
//  Created by Beatriz Duque on 07/03/22.
//

import Foundation
import GameController

protocol JoystickDelegate: AnyObject{
    func controllerDidConnect(controller: GCController)
    func controllerDidDisconnect()
    func keyboardDidConnect(keyboard: GCKeyboard)
    func keyboardDidDisconnect(keyboard: GCKeyboard)
    func buttonPressed(command: GameCommand)
    func buttonReleased(command: GameCommand)
    func joystickUpdate(_ currentTime: TimeInterval)
}
