//
//  GameScene+tvOS.swift
//  DinoEscape
//
//  Created by Beatriz Duque on 17/03/22.
//

import Foundation
import SpriteKit


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
        
        let pause =  UITapGestureRecognizer()
        pause.addTarget(self, action: #selector(self.respondToPause))
        pause.allowedPressTypes = [NSNumber(value: UIPress.PressType.playPause.rawValue)]
        
        let play = UITapGestureRecognizer()
        play.addTarget(self, action: #selector(self.respondToPlay))
        //play.allowedPressTypes = [NSNumber(value: UIPress.PressType.playPause.rawValue)]
        
        let menu = UITapGestureRecognizer()
        menu.addTarget(self, action: #selector(self.respondToMenu))
        menu.allowedPressTypes = [NSNumber(value: UIPress.PressType.menu.rawValue)]
        
        self.view?.addGestureRecognizer(pause)
        self.view?.addGestureRecognizer(play)
        self.view?.addGestureRecognizer(menu)
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
    @objc func respondToPause(gesture: UITapGestureRecognizer) {
            if let tapGesture = gesture as? UITapGestureRecognizer {
                GameController.shared.getPause(pause: tapGesture)
            }
    }
    
    @objc func respondToPlay(gesture: UITapGestureRecognizer) {
        if let tapGesture = gesture as? UITapGestureRecognizer {
            GameController.shared.getPlay(play: tapGesture)
        }
    }
    
    @objc func respondToMenu(gesture: UITapGestureRecognizer) {
        if let tapGesture = gesture as? UITapGestureRecognizer {
            GameController.shared.getMenu(menu: tapGesture)
            
        }
    }
    
}
#endif
