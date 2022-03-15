//
//  EggScene.swift
//  DinoEscape iOS
//
//  Created by Leticia Utsunomiya on 15/03/22.
//

import Foundation
import SpriteKit

class EggScene: SKScene {
    

var coins: Int = 1000


class func newGameScene() -> EggScene {
    let scene = EggScene()
    scene.scaleMode = .resizeFill
    GameController.shared.setScene(scene: scene)
    return scene
}

func setUpScene() {
    self.isUserInteractionEnabled = true
    
    backgroundColor = SKColor(red: 1, green: 0, blue: 0, alpha: 1)
//    SKColor(red: 235/255, green: 231/255, blue: 198/255, alpha: 1)
    
    removeAllChildren()
    removeAllActions()
    
    createSegButton(name: .dinos ,pos: 0)
    createSegButton(name: .dinos ,pos: 1)
    createReward(name: .btn,pos: 0)
    createReward(name: .btn,pos: 1)

    let dinoChoosed: SKSpriteNode = SKSpriteNode(imageNamed: "T-Rex")
    
    dinoChoosed.position = CGPoint(x: size.width/2, y: size.height/2)
    dinoChoosed.size = CGSize(width: size.width/1.5, height: size.height/2)
    addChild(dinoChoosed)
}
    
    

func createSegButton(name: SegmentageType, pos: Int) {
    let texture: SKTexture = SKTexture(imageNamed: "\(name.rawValue)")
    texture.filteringMode = .nearest
    
    let w: CGFloat = size.width / 3.5
    let h = w * texture.size().height / texture.size().width
    
    let segmentage: SKButton = SKButton(texture: texture, color: .blue, size: CGSize(width: w, height: h))
    
    
    segmentage.position = CGPoint(
        x: segmentage.frame.width / 0.85 + CGFloat(pos) * segmentage.frame.width * 1.1,
        y: size.height / 1.2 )
    
    
    
    segmentage.selectedHandler = {
        print(name)
        
    }
    
    addChild(segmentage)
    
}
    func createReward(name: EggType, pos: Int) {
        let texture: SKTexture = SKTexture(imageNamed: "\(name.rawValue)")
        texture.filteringMode = .nearest
        
        let w: CGFloat = size.width / 3
        let h = w * texture.size().height / texture.size().width
        
        let segmentage: SKButton = SKButton(texture: texture, color: .red, size: CGSize(width: w, height: h))
        
        
        segmentage.position = CGPoint(
            x: segmentage.frame.width / 1.1 + CGFloat(pos) * segmentage.frame.width * 1.2,
            y: size.height / 6 )
        
        
        
        segmentage.selectedHandler = {
            print(name)
            
        }
        
        addChild(segmentage)
        
    }

override func didChangeSize(_ oldSize: CGSize) {
    super.didChangeSize(oldSize)
    
    setUpScene()
}

}
