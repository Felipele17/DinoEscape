//
//  JoystickAnalogic.swift
//  DinoEscape
//
//  Created by Raphael Alkamim on 08/03/22.
//

import Foundation
import SpriteKit

class AnalogStick: SKNode {
    
    private let stick: SKShapeNode
    private let outline: SKShapeNode
    private var isUsing: Bool
    private var velocityX: CGFloat
    private var velocityY: CGFloat

    
    init(position: CGPoint = .zero) {
        self.stick = SKShapeNode(circleOfRadius: 30)
        self.outline = SKShapeNode(circleOfRadius: 80)
        self.outline.alpha = 0.5
        isUsing = false
        velocityX = 0
        velocityY = 0
        super.init()
        self.position = position
        self.isUserInteractionEnabled = true
        createStick(named: "iOScontroller")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func createStick(named: String) {
        
        self.addChild(outline)
        stick.name = named
        stick.zPosition = 1
        stick.fillColor = .darkGray
        stick.strokeColor = .darkGray
        
        outline.name = named
        outline.position = position
        outline.zPosition = 1
        outline.fillColor = .gray
        outline.strokeColor = .gray
        outline.addChild(stick)
       
        //outline.isUserInteractionEnabled = true
    }
    
    public func changeState() {
        if !isUsing {
            isUsing = true
            print(isUsing)
        }
    }
    
    public func updateVector(for location: CGPoint) {
        if isUsing {
            let vector = CGVector(dx: location.x - outline.position.x, dy: location.y - outline.position.y)
            let angle = atan2(vector.dy, vector.dx)
            let outlineRadius: CGFloat = 80
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
            
            GameController.shared.gameData.player?.gameCommand = changePlayerCommand(vx: velocityX, vy: velocityY)
//            player.zRotation = angle
        }
    }
    
    public func getVelocity() -> CGVector {
        return CGVector(dx: velocityX, dy: velocityY)
    }
    
    public func getStickPosition() -> CGPoint {
        return stick.position
    }
    
    public func resetStick() {
        if isUsing {
            stick.position = .zero
            velocityX = 0
            velocityY = 0
            isUsing = false
        }
    }
    
    public func changePlayerCommand(vx: CGFloat, vy: CGFloat)  -> GameCommand {
        if (vx < 0.2) && (vx > -0.2) && vy > 0 { return .UP }
        if (vx < 0.2) && (vx > -0.2) && vy < 0 { return .DOWN }
        if  vx <= -0.2 { return .LEFT }
        if  vx >=  0.2 { return .RIGHT }
        return .LEFT
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        changeState()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        for touch in touches {
            let location = touch.location(in: self)
            updateVector(for: location)
            
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        resetStick()
    }
    
    #if os( tvOS )
    
    convenience override init() {
        self.init()
    }
    
    override public var canBecomeFocused: Bool {
        get {
            return true
        }
    }
    
    func buttonDidGetFocus() {
        GameController.renderer.scene.addChild(GameController.shared.joystickController.virtualController)
        print("didGetFocus")
    }
    
    func buttonDidLoseFocus() {
        print("didLoseFocus")
    }
    #endif
}
