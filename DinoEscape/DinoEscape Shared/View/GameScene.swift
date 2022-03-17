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
    }
    override func didMove(to view: SKView) {
        //setando a cena
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

#if os(tvOS)
// Touch-based event handling
extension GameScene {
    
    public func changePlayerCommand(vx: CGFloat, vy: CGFloat)  -> GameCommand {
        if (vx < 0.2) && (vx > -0.2) && vy > 0 { return .UP }
        if (vx < 0.2) && (vx > -0.2) && vy < 0 { return .DOWN }
        if  vx <= -0.2 { return .LEFT }
        if  vx >=  0.2 { return .RIGHT }
        return .LEFT
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        print("tocou")
        
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        for touch in touches {
            let location = touch.location(in: scene!)
            let velocityX = (location.x) / 100
            print("batata",location.x)
            let velocityY = (location.y) / 100
            
            GameController.shared.gameData.player?.gameCommand = changePlayerCommand(vx: velocityX, vy: velocityY)
            
            GameController.shared.movePlayer(dx: GameController.shared.gameData.player?.dinoVx ?? 0, dy: GameController.shared.gameData.player?.dinoVy ?? 0)


        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    
}
#endif

#if os(OSX)
// Mouse-based event handling
extension GameScene {
    
    override func mouseDown(with event: NSEvent) {
        
    }
    
    override func mouseDragged(with event: NSEvent) {
    }
    
    override func mouseUp(with event: NSEvent) {
    }
    
}
#endif


