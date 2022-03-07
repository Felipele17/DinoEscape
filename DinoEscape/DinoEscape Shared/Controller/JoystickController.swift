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
    
    #if os( iOs )
    // MARK: Controle virtual para iOS
    private var _virtualController: Any?
    
    @available(iOS 15.0, *)
    public var virtualController: GCVirtualController? {
        get { return self._virtualController as? GCVirtualController}
        set { self._virtualController = newValue}
    }
    #endif
    
    init(){
        //preenchendo o mapa com os comandos do jogo
        
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
}
