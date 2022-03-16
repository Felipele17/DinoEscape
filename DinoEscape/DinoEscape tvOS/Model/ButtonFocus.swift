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
        self.isUserInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var canBecomeFocused: Bool {
        return true
    }
}
