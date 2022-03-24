//
//  JoystickController.swift
//  DinoEscape iOS
//
//  Created by Beatriz Duque on 07/03/22.
//

import Foundation
import SpriteKit
import GameController


class JoystickController{
    weak var delegate: JoystickDelegate?
    
    var gamePadLeft: GCControllerDirectionPad?
    var keyMap: [GCKeyCode : GameCommand] = [:] //mapeia os comandos do jogo
    
#if os( iOS )
    // MARK: Controle virtual para iOS
    private var _virtualController: Any?
    
    @available(iOS 15.0, *)
    public var virtualController: AnalogStick
#endif
    
    init(){
        //controle desenhado na tela apenas para iOS
        #if os( iOS )
            virtualController = AnalogStick(position: CGPoint(x: 0, y: 0))
        #endif
        
        //preenchendo o mapa com os comandos do jogo
        
        // pausar
        keyMap[.escape] = .PAUSE
        
        //opcao com as setinhas
        keyMap[.rightArrow] = .RIGHT
        keyMap[.leftArrow] = .LEFT
        keyMap[.upArrow] = .UP
        keyMap[.downArrow] = .DOWN
        
        //opcao WASD
        keyMap[.keyD] = .RIGHT
        keyMap[.keyA] = .LEFT
        keyMap[.keyW] = .UP
        keyMap[.keyS] = .DOWN
    }
    
    func observeForGameControllers(){
        NotificationCenter.default.addObserver(self, selector: #selector(self.handleControllerDidConnect), name: NSNotification.Name.GCControllerDidBecomeCurrent, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.handleControllerDidDisconnect), name: NSNotification.Name.GCControllerDidStopBeingCurrent, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.handleKeyboardDidConnect), name: NSNotification.Name.GCMouseDidConnect, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.handleKeyboardDidDisconnect),
                                               name: NSNotification.Name.GCKeyboardDidDisconnect, object: nil)
        
        /// pega os controles que estao conectados no sistema e seleciona o primeiro para ser registrado
        guard let controller = GCController.controllers().first else {
            return
        }
        registerGameController(controller)
    }
    
    @objc
    func handleControllerDidConnect(_ notification: Notification) {
        guard let gameController = notification.object as? GCController else {
            return
        }
        unregisterGameController()
        
        registerGameController(gameController)
        
        delegate?.controllerDidConnect(controller: gameController)
    }
    
    @objc
    func handleControllerDidDisconnect(_ notification: Notification) {
        unregisterGameController()
        delegate?.controllerDidDisconnect()
    }
    
    @objc
    func handleKeyboardDidConnect(_ notification: Notification) {
        guard let keyboard = notification.object as? GCKeyboard else {
            return
        }
        delegate?.keyboardDidConnect(keyboard: keyboard)
    }
    
    @objc
    func handleKeyboardDidDisconnect(_ notification: Notification) {
        guard let keyboard = notification.object as? GCKeyboard else {
            return
        }
        delegate?.keyboardDidDisconnect(keyboard: keyboard)
    }
    
    func registerGameController(_ gameController: GCController) {
        
        // para mudar a cor do led do controle de PS4
        // gameController.light?.color = GCColor(red: 0.5, green: 0.5, blue: 0.5)
        
        if let gamepad = gameController.extendedGamepad {
            self.gamePadLeft = gamepad.leftThumbstick
            
        } else if let gamepad = gameController.microGamepad {
            self.gamePadLeft = gamepad.dpad
        }
    }
    
    func unregisterGameController() {
        gamePadLeft = nil
    }
    
    func checkForKeyboard() {
        if let keyboard = GCKeyboard.coalesced?.keyboardInput {
            keyboard.keyChangedHandler = { (keyboard, key, keyCode, pressed) in
                guard let direction: GameCommand = self.keyMap[keyCode] else { return }
                
                if pressed {
                    self.pressButton( direction )
                } else {
                    self.releaseButton( direction )
                }
            }
        }
    }
    #if os(tvOS)
    func respondToSwipeGesture(gesture: UIGestureRecognizer) {
            if let swipeGesture = gesture as? UISwipeGestureRecognizer {
                switch swipeGesture.direction {
                case .right:
                    self.pressButton( .RIGHT )
                case .down:
                    self.pressButton( .DOWN )
                case .left:
                    self.pressButton( .LEFT )
                case .up:
                    self.pressButton( .UP )
                default:
                    break
                }
            }
    }
    func respondToPause(pause: UITapGestureRecognizer){
        if let tapGesture = pause as? UITapGestureRecognizer {
            self.pressButton(.PAUSE)
        }
    }
    #endif
    
    // MARK: Buttons
    func pressButton(_ command: GameCommand){
        delegate?.buttonPressed(command: command)
        delegate?.selectPlayerState(command: command)

    }
    
    func releaseButton(_ command: GameCommand){
        delegate?.buttonReleased(command: command)
        delegate?.selectPlayerState(command: command)
    }
    
    func update(_ currentTime: TimeInterval) {
        checkForKeyboard()
        #if os(tvOS)
        if let swipe = GameController.shared.swipe{
            respondToSwipeGesture(gesture: swipe)
        }
        if let pause = GameController.shared.pause{
            respondToPause(pause: pause)
        }
        #endif
        delegate?.joystickUpdate(currentTime)
    }
}

