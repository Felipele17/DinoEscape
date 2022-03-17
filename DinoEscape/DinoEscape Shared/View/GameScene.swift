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
    
    func setGesture(){
        let swipeUp : UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeUp.direction = .up
                
        let swipeDown: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeDown.direction = .down
        
        let swipeLeft : UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeLeft.direction = .left

        let swipeRight : UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeRight.direction = .right
        
        self.view?.addGestureRecognizer(swipeUp)
        self.view?.addGestureRecognizer(swipeDown)
        self.view?.addGestureRecognizer(swipeLeft)
        self.view?.addGestureRecognizer(swipeRight)
    }
    
    
    public func changePlayerCommand(vx: CGFloat, vy: CGFloat)  -> GameCommand {
        if (vx < 0.2) && (vx > -0.2) && vy > 0 { return .UP }
        if (vx < 0.2) && (vx > -0.2) && vy < 0 { return .DOWN }
        if  vx <= -0.2 { return .LEFT }
        if  vx >=  0.2 { return .RIGHT }
        return .LEFT
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        for touch in touches {
            let location = touch.location(in: scene!)
            let velocityX = (location.x) / 100
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
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
            if let swipeGesture = gesture as? UISwipeGestureRecognizer {
                GameController.shared.getSwipe(swipe: swipeGesture)
            }
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


