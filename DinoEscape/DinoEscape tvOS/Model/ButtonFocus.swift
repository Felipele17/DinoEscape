//
//  ButtonFocus.swift
//  DinoEscape tvOS
//
//  Created by Bianca Maciel Matos on 14/03/22.
//

import UIKit
import SpriteKit

class ButtonFocus: SKNode {

    var touchStart: CGPoint?
    var isFocused: Bool = false
    
    // mexendo com o joystick
    let sourcePositions: [vector_float2] = [
        vector_float2(0,1),     vector_float2(1,1),
        vector_float2(0,0),     vector_float2(1,0)
    ]
    
    init(value: Int) {
        super.init()
        let bg = SKSpriteNode()
        self.isUserInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var canBecomeFocused: Bool {
        return true
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
    
    func gainedFocus() {
        if let bg = self.
    }

    
    enum Direction: Int {
        case UP = 0, RIGHT, DOWN, LEFT;
    }
}
