//
//  GameController.swift
//  DinoEscape iOS
//
//  Created by Beatriz Duque on 07/03/22.
//

import Foundation
import SpriteKit
import GameController

class GameController{
    static var shared: GameController = {
        let instance = GameController()
        return instance
    }()
    
    var gameData: GameData
    var renderer: RenderController
    let joystickController: JoystickController = JoystickController()
    
    private init(){
        let player = Player(name: "DinoRex",
                            color: .yellow,
                            position: CGPoint(x: 0, y: 0),
                            size: CGSize(width: 50, height: 50),
                            skin: .dino1,
                            gameCommand: .UP,
                            powerUp: .none)
        gameData = GameData(player: player)
        renderer = RenderController()
    }
    
    func setScene(scene: SKScene){
        renderer.scene = scene
        
    }
    
    func setupScene(){
        let player = GameController.shared.gameData.player!
        player.position = CGPoint(x: renderer.scene.size.width/2, y: renderer.scene.size.height/2)
        
        #if os( iOS )
        joystickController.virtualController.position = CGPoint(x: renderer.scene.size.width/2, y: renderer.scene.size.height/7)
        #endif
        
        renderer.setUpScene()
        joystickController.delegate = self
        joystickController.observeForGameControllers()
    }
    
    func update(_ currentTime: TimeInterval){
        joystickController.update(currentTime)
        
        movePlayer(dx: gameData.player?.dinoVx ?? 0, dy: gameData.player?.dinoVy ?? 0)
        renderer.update(currentTime)
    }
    
    func movePlayer(dx: CGFloat, dy: CGFloat){
#warning("Adicionar nessa funcao a passagem por parametro da direcao")
        
        if let player = gameData.player {
            // Iguala size do player para size da hitBox
            player.size = CGSize(width: renderer.hitBoxNode.frame.width, height: renderer.hitBoxNode.frame.height)
            let mult = player.foodBar
            let midWidthPlayer = player.size.width/2
            let midHeightPlayer = player.size.height/2
            
            var xValue = player.position.x + dx * mult
            if xValue > renderer.scene.size.width * 0.94 - midWidthPlayer{
                xValue = renderer.scene.size.width * 0.94 - midWidthPlayer
            } else if xValue < renderer.scene.size.width * 0.06 + midWidthPlayer{
                xValue = renderer.scene.size.width * 0.06 + midWidthPlayer
            }
           
            
            var yValue = player.position.y + dy * mult
            if yValue > renderer.scene.size.height * 0.84 - midHeightPlayer{
                yValue = renderer.scene.size.height * 0.84 - midHeightPlayer
            } else if yValue < renderer.scene.size.height * 0.125 + midHeightPlayer{
                yValue = renderer.scene.size.height * 0.125 + midHeightPlayer
            }
            
            player.position = CGPoint(x: xValue, y: yValue)
            player.points = Int(player.position.x)
            player.foodBar = 6
        }
        
        
        
        
    }
}

