//
//  GameViewController.swift
//  DinoEscape tvOS
//
//  Created by Felipe Leite on 07/03/22.
//

// swiftlint:disable force_cast

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scene = HomeScene.newGameScene()

        let gController = GameCenterController(viewController: self)
        gController.setupActionPoint(location: .bottomLeading, showHighlights: true, isActive: true)

        // Present the scene
        let skView = self.view as! SKView
        skView.presentScene(scene)
        
        skView.ignoresSiblingOrder = true
        
    }
}
