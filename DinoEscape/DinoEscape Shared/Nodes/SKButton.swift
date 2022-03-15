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

