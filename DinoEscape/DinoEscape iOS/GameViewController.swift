//
//  GameViewController.swift
//  DinoEscape iOS
//
//  Created by Felipe Leite on 07/03/22.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    var gController: GameCenterController?

    override func viewDidLoad() {
        super.viewDidLoad()
        //let scene = GameOverScene.newGameScene()
        let scene = HomeScene.newGameScene()


        let gController = GameCenterController(viewController: self)
        gController.setupActionPoint(location: .bottomLeading, showHighlights: true, isActive: true)
        
        // Present the scene
        let skView = self.view as! SKView
        skView.presentScene(scene)
        
        skView.ignoresSiblingOrder = true
    }

    
    override var shouldAutorotate: Bool {
        return false
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
