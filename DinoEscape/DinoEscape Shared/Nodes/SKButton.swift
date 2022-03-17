//
//  ButtonNode.swift
//  DinoEscape iOS
//
//  Created by Raphael Alkamim on 11/03/22.
//

import Foundation
import SpriteKit

enum ButtonNodeState {
    case active, selected, disabled
}

class SKButton: SKSpriteNode {
    var isButtonEnabled = true
    var selectedHandler: () -> Void = { print("No button action set") }
    
    
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        self.isUserInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.isUserInteractionEnabled = true
    }
    
    var state: ButtonNodeState = .active {
        didSet {
            switch state {
            case .active:
                self.isUserInteractionEnabled = true
                self.alpha = 1
                break
                
            case .selected:
                self.alpha = 0.7
                break
                
            case .disabled:
                self.isUserInteractionEnabled = false
                self.alpha = 0.2
                break
            }
        }
    }
    
#if os( tvOS )
    var touchStart: CGPoint?
    var isFocused: Bool = true
    
    // mexendo com o joystick
    let sourcePositions: [vector_float2] = [
        vector_float2(0,1),     vector_float2(1,1),
        vector_float2(0,0),     vector_float2(1,0)
    ]
    
    override var canBecomeFocused: Bool {
        return isFocused
    }
    
    // alterando a inclinação do objeto
    func getLeanGeometry(shift: Float, direction: Direction) -> [vector_float2] {
        switch direction {
        case .LEFT:
            return [
                vector_float2(0.0 + shift, 1.0 - shift), vector_float2(1.0 + shift, 1.0 + shift),
                vector_float2(0.0 + shift, 0 + shift), vector_float2(1.0 + shift, 0 - shift)
            ]
            
        case .RIGHT:
            return [
                vector_float2(0.0 - shift, 1.0 + shift), vector_float2(1.0 - shift, 1.0 - shift),
                vector_float2(0.0 - shift, 0 - shift), vector_float2(1.0 - shift, 0 + shift)
            ]
        case .UP:
            return [
                vector_float2(0.0 - shift, 1.0 + shift), vector_float2(1.0 + shift, 1.0 + shift),
                vector_float2(0.0 + shift, 0 + shift), vector_float2(1.0 - shift, 0 + shift)
            ]
        case .DOWN:
            return [
                vector_float2(0.0 + shift, 1.0 - shift), vector_float2(1.0 - shift, 1.0 - shift),
                vector_float2(0.0 - shift, 0 - shift), vector_float2(1.0 + shift, 0 - shift)
            ]
        }
    }
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        if context.previouslyFocusedItem === self {
            self.setScale(self.xScale/1.1)
            self.setScale(self.yScale/1.1)
            self.alpha = 0.75
        }
        
        if context.nextFocusedItem === self {
            self.setScale(self.xScale * 1.1)
            self.setScale(self.yScale * 1.1)
            self.alpha = 1
        }
    }
    
    
    enum Direction: Int {
        case UP = 0, RIGHT, DOWN, LEFT;
    }
#endif
    
}



extension SKButton {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isButtonEnabled{
            state = .selected
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isButtonEnabled {
            selectedHandler()
            state = .active
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
}


