//
//  SettingsPopUpScene+tvOS.swift
//  DinoEscape
//
//  Created by Felipe Leite on 24/03/22.
//

import Foundation
import SpriteKit
import UIKit

#if os( tvOS )
extension SettingsPopUpScene {
    
    func setFocusOnBackButton() {
        print("hello")
    }
    
    @objc func respondToBackButton(gesture: UITapGestureRecognizer) {
            if let backButton = gesture as? UITapGestureRecognizer {
                GameController.shared.getBackButton(backButton: backButton)
            }
    }
    
}
#endif
