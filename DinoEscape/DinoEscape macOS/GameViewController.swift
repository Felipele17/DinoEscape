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
            UserDefaults.standard.set(true, forKey: "isFirstRun")
        }
        
        #warning("deletar coredata -> apenas para testes")
        //try! SkinDataModel.deleteCoreData(skins: dinos)

        super.viewDidLoad()
        
        //let scene = EggScene.newGameScene()
        //let scene = SettingsScene.newGameScene()
        //let scene = GameScene.newGameScene()
        let scene = HomeScene.newGameScene()
        //let scene = StoreScene.newGameScene()
        //scene.delegateGameCenter = self

        

        let gController = GameCenterController(viewController: self)
        gController.setupActionPoint(location: .bottomLeading, showHighlights: true, isActive: true)

        // Present the scene
        let skView = self.view as! SKView
        skView.presentScene(scene)
        
        skView.ignoresSiblingOrder = true
    
    }
    

}

