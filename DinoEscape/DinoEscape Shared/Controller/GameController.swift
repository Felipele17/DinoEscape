//
//  GameController.swift
//  DinoEscape iOS
//
//  Created by Beatriz Duque on 07/03/22.
//

import Foundation
import SpriteKit


class GameController{
    static var shared: GameController = {
       let instance = GameController()
        return instance
    }()
    
    var gameData: GameData
    var renderer: RenderController
    
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
        
        renderer.setUpScene()
    }
    
    func update(_ currentTime: TimeInterval){
        gameData.player?.position.x += 1
        
        renderer.update(currentTime)
    }
    
    func movePlayer(){
        // adicionar nessa funcao a passagem por parametro da direcao
        gameData.player?.position.y += 10
    }
}
