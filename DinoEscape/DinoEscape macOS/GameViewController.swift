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
        let dinos = try! SkinDataModel.getSkins()
        if dinos.count == 0 {
            CreateCoreData.shared.create()
            UserDefaults.standard.set(true, forKey: "music")
            UserDefaults.standard.set(true, forKey: "vibration")
        }
//        print("rex",dinos[0].image)
//        print("rex",dinos[0].isBought)
//        print("rex",dinos[0].isSelected)

        
//        for dino in dinos{
//            try! SkinDataModel.deleteSkin(skin: dino)
//        }
        
        super.viewDidLoad()
        
        //let scene = EggScene.newGameScene()
        //let scene = SettingsScene.newGameScene()
        let scene = GameOverScene.newGameScene()
        //let scene = HomeScene.newGameScene()
        //let scene = StoreScene.newGameScene()
        //scene.delegateGameCenter = self

        

        let gController = GameCenterController(viewController: self)
        gController.setupActionPoint(location: .bottomLeading, showHighlights: true, isActive: true)

        // Present the scene
        let skView = self.view as! SKView
        skView.presentScene(scene)
        
        skView.ignoresSiblingOrder = true
        
        skView.showsFPS = true
        skView.showsNodeCount = true
    }

}

