//
//  GameScene.swift
//  DinoEscape Shared
//
//  Created by Felipe Leite on 07/03/22.
//

import SpriteKit

class GameScene: MyScene {
    class func newGameScene() -> GameScene {
        let scene = GameScene()
        scene.scaleMode = .resizeFill
        GameController.shared.setScene(scene: scene)
        return scene
    }
    
    func setUpScene() {
        GameController.shared.setupScene()
        #if os(tvOS)
        self.setGesture()
        #endif
        
    }
    override func didMove(to view: SKView) {
        // setando a cena
        self.setUpScene()
    }
    
    override func didChangeSize(_ oldSize: CGSize) {
        super.didChangeSize(oldSize)
        self.setUpScene()
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        GameController.shared.update(currentTime)
    }
    
}
