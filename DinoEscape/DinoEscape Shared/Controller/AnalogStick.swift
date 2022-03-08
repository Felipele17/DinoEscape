//
//  JoystickAnalogic.swift
//  DinoEscape
//
//  Created by Raphael Alkamim on 08/03/22.
//

import Foundation
import SpriteKit

class AnalogStick {
    
    private let stick: SKShapeNode
    private let outline: SKShapeNode
    private var isUsing: Bool
    private var velocityX: CGFloat
    private var velocityY: CGFloat
    private var position: CGPoint
    
    init(position: CGPoint = .zero) {
        self.stick = SKShapeNode(circleOfRadius: 20)
        self.outline = SKShapeNode(circleOfRadius: 100)
        self.outline.alpha = 0.5
        isUsing = false
        velocityX = 0
        velocityY = 0
        self.position = position
    }
    
    func createStick(named: String) -> SKShapeNode {
        
        stick.name = named
        stick.zPosition = 1
        stick.fillColor = .red
        
        outline.name = named
        outline.position = position
        outline.zPosition = 1
        outline.fillColor = .blue
    
        outline.addChild(stick)
        
        
        return outline
    }
    
    public func changeState() {
        if !isUsing {
            isUsing = true
        }
    }
    
    public func updateVector(for location: CGPoint) {
        if isUsing {
            let vector = CGVector(dx: location.x - outline.position.x, dy: location.y - outline.position.y)
            let angle = atan2(vector.dy, vector.dx)
            let outlineRadius: CGFloat = 128
            let distanceX: CGFloat = sin(angle - CGFloat.pi/2) * outlineRadius
            let distanceY: CGFloat = cos(angle - CGFloat.pi/2) * outlineRadius
            
            if abs(vector.dx) < abs(distanceX) || abs(vector.dy) < abs(distanceY) {
                stick.position.x = vector.dx
                stick.position.y = vector.dy
            } else {
                stick.position = CGPoint(x: -distanceX, y: distanceY)
            }
            
            velocityX = (stick.position.x) / 100
            velocityY = (stick.position.y) / 100
            
//            player.zRotation = angle
        }
    }
    
    
    //Pega velocidade do movimento do dino
    public func getVelocity() -> CGVector {
        return CGVector(dx: velocityX, dy: velocityY)
    }
    
    
    public func getStickPosition() -> CGPoint {
        return stick.position
    }
    
    // Reseta o sticker na posição zero quando não estiver sendo usado
    public func resetStick() {
        if isUsing {
            stick.position = .zero
            velocityX = 0
            velocityY = 0
            isUsing = false
        }
    }
}
