//
//  GameViewController.swift
//  DinoEscape macOS
//
//  Created by Felipe Leite on 07/03/22.
//

import Cocoa
import SpriteKit
import GameplayKit

class GameViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scene = GameScene.newGameScene()
        scene.delegateGameCenter = self

        let gController = GameCenterController(viewController: self)
        gController.setupActionPoint(location: .topLeading, showHighlights: true, isActive: true)
            
        // Present the scene
        let skView = self.view as! SKView
        skView.presentScene(scene)
        
        skView.ignoresSiblingOrder = true
        
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.showsPhysics = true
    }

}

