//
//  GameViewController.swift
//  DinoEscape macOS
//
//  Created by Felipe Leite on 07/03/22.
//

// swiftlint:disable force_cast

import Cocoa
import SpriteKit
import GameplayKit

class GameViewController: NSViewController {
    override func viewDidLoad() {
        let dinos = SkinDataModel.shared.getSkins()
        if dinos.isEmpty == 0 {
            CreateCoreData.shared.create()
            UserDefaults.standard.set(true, forKey: "music")
            UserDefaults.standard.set(true, forKey: "vibration")
            UserDefaults.standard.set(true, forKey: "isFirstRun")
        }

        super.viewDidLoad()
        
        let scene = HomeScene.newGameScene()
        let gController = GameCenterController(viewController: self)
        gController.setupActionPoint(location: .bottomLeading, showHighlights: true, isActive: true)

        let skView = self.view as! SKView
        skView.presentScene(scene)
        
        skView.ignoresSiblingOrder = true
    
    }
}
