//
//  StoreSceneIOS.swift
//  DinoEscape iOS
//
//  Created by Raphael Alkamim on 11/03/22.
//

import Foundation
import SpriteKit

class StoreScene: SKScene {
    
    var coins: Int = 1000
    
    
    
    class func newGameScene() -> StoreScene {
        let scene = StoreScene()
        scene.scaleMode = .resizeFill
        GameController.shared.setScene(scene: scene)
        return scene
    }
    
    
    func setUpScene() {
        self.isUserInteractionEnabled = true
        
        backgroundColor = SKColor(red: 235/255, green: 231/255, blue: 198/255, alpha: 1)
        
        removeAllChildren()
        removeAllActions()
        
        
        createSegButton(name: .dinos ,pos: 0)
        createSegButton(name: .dinos ,pos: 1)
        
        createDino(name: .t_rex, posX: 0, posY: 0)
        createDino(name: .t_rex, posX: 1, posY: 0)
        //createDino(name: .t_rex, posX: 2, posY: 0)
        createDino(name: .t_rex, posX: 0, posY: 1)
        createDino(name: .t_rex, posX: 1, posY: 1)
        createDino(name: .t_rex, posX: 2, posY: 1)
        
        let dinoChoosed: SKSpriteNode = SKSpriteNode(imageNamed: "T-Rex")
        
        dinoChoosed.position = CGPoint(x: size.width/2, y: size.height/3)
        dinoChoosed.size = CGSize(width: size.width/1.5, height: size.height/4)
        addChild(dinoChoosed)
        
    }
    
    func createADSButton(pos: Int) {
        
    
        
    }
    
    
    func createSegButton(name: SegmentageType, pos: Int) {
        let texture: SKTexture = SKTexture(imageNamed: "\(name.rawValue)")
        texture.filteringMode = .nearest
        
        let w: CGFloat = size.width / 3
        let h = w * texture.size().height / texture.size().width
        
        let segmentage: SKButton = SKButton(texture: texture, color: .blue, size: CGSize(width: w, height: h))
        
        
        segmentage.position = CGPoint(
            x: segmentage.frame.width / 1.2 + CGFloat(pos) * segmentage.frame.width * 1.3,
            y: size.height / 1.2 )
        
        
        
        segmentage.selectedHandler = {
            print(name)
            
        }
        
        addChild(segmentage)
        
    }
        
    
    func createDino(name: DinoType, posX: Int, posY: Int) {
        let texture: SKTexture = SKTexture(imageNamed: "\(name.rawValue)")
        texture.filteringMode = .nearest
        
        let w: CGFloat = size.width / 3.8
        let h = w * texture.size().height / texture.size().width
        
        let dinoButton: SKButton = SKButton(texture: texture, color: .clear, size: CGSize(width: w, height: h))
        
        
        dinoButton.position = CGPoint(
            x: dinoButton.frame.width / 1.2 + CGFloat(posX) * dinoButton.frame.width * 1.1,
            y: size.height / 1.8 + CGFloat(posY) * dinoButton.frame.height * 1.2 )
        
        
        
        dinoButton.selectedHandler = {
            print(name)
            
        }
        
        addChild(dinoButton)
        
    }
    
    
    override func didChangeSize(_ oldSize: CGSize) {
        super.didChangeSize(oldSize)
        
        setUpScene()
    }
    
}
