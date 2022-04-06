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
    func setGesture() {
        let swipeUp: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeUp.direction = .up
        
        let swipeDown: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeDown.direction = .down
        
        let swipeLeft: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeLeft.direction = .left
        
        let swipeRight: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeRight.direction = .right
        
        let pause = UITapGestureRecognizer()
        pause.addTarget(self, action: #selector(self.respondToPause))
        pause.allowedPressTypes = [NSNumber(value: UIPress.PressType.playPause.rawValue)]
        
        let play = UITapGestureRecognizer()
        play.addTarget(self, action: #selector(self.respondToPlay))
        // play.allowedPressTypes = [NSNumber(value: UIPress.PressType.playPause.rawValue)]
        
        let menu = UITapGestureRecognizer()
        menu.addTarget(self, action: #selector(self.respondToMenu))
        menu.allowedPressTypes = [NSNumber(value: UIPress.PressType.menu.rawValue)]
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.respondToTap(gesture:)))
        self.view?.addGestureRecognizer(tapRecognizer)
        
        self.view?.addGestureRecognizer(pause)
        self.view?.addGestureRecognizer(play)
        self.view?.addGestureRecognizer(menu)
        self.view?.addGestureRecognizer(swipeUp)
        self.view?.addGestureRecognizer(swipeDown)
        self.view?.addGestureRecognizer(swipeLeft)
        self.view?.addGestureRecognizer(swipeRight)
    }
    
    public func changePlayerCommand(velocityX: CGFloat, velocityY: CGFloat) -> GameCommand {
        if (velocityX < 0.2) && (velocityX > -0.2) && velocityY > 0 { return .UP }
        if (velocityX < 0.2) && (velocityX > -0.2) && velocityY < 0 { return .DOWN }
        if  velocityX <= -0.2 { return .LEFT }
        if  velocityX >= 0.2 { return .RIGHT }
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
            
            GameController.shared.gameData.player?.gameCommand = changePlayerCommand(velocityX: velocityX, velocityY: velocityY)
            GameController.shared.movePlayer(directionX: GameController.shared.gameData.player?.dinoVx ?? 0, directionY: GameController.shared.gameData.player?.dinoVy ?? 0)
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
        GameController.shared.getPause(pause: gesture)
    }
    
    @objc func respondToPlay(gesture: UITapGestureRecognizer) {
        GameController.shared.getPlay(play: gesture)
    }
    
    @objc func respondToMenu(gesture: UITapGestureRecognizer) {
        GameController.shared.getMenu(menu: gesture)
    }
    @objc func respondToTap(gesture: UITapGestureRecognizer) {
        GameController.shared.getTap(menu: gesture)
    }
    
}
#endif
