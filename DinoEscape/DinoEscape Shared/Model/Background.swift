//
//  Background.swift
//  DinoEscape
//
//  Created by Luca Hummel on 17/03/22.
//

import Foundation

class Backgrounds{
    static var shared: Backgrounds = {
        let instance = Backgrounds()
        return instance
    }()
    
    var background = "redBackground"
    func redBackground() -> String{
        #if os(iOS)
        return background
        #else
        return background+"Mac"
        #endif
    }
    func blueBackground() -> String{
        background = "blueBackground"
        #if os(iOS)
        return background
        #else
        return background+"Mac"
        #endif
    }
    func lightGreenBackground() -> String{
        background = "lightGreenBackground"
        #if os(iOS)
        return background
        #else
        return background+"Mac"
        #endif
    }
    func GreenBackground() -> String{
        background = "greenBackground"
        #if os(iOS)
        return background
        #else
        return background+"Mac"
        #endif
    }
    func cityBackground() -> String{
        background = "cityBackground"
        #if os(iOS)
        return background
        #else
        return background+"Mac"
        #endif
    }
    func planetBackground() -> String{
        background = "planetBackground"

        #if os(iOS)
        return background
        #else
        return background+"Mac"
        #endif
    }
}
