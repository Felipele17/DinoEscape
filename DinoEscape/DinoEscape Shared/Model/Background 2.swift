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
        #if os(iOS)
        background = "blueBackground"
        return background
        #else
        return background+"Mac"
        #endif
    }
    func lightGreenBackground() -> String{
        #if os(iOS)
        background = "lightGreenBackground"
        return background
        #else
        return background+"Mac"
        #endif
    }
    func GreenBackground() -> String{
        #if os(iOS)
        background = "greenBackground"
        return background
        #else
        return background+"Mac"
        #endif
    }
    func cityBackground() -> String{
        #if os(iOS)
        background = "cityBackground"
        return background
        #else
        return background+"Mac"
        #endif
    }
    func planetBackground() -> String{
        #if os(iOS)
        background = "planetBackground"
        return background
        #else
        return background+"Mac"
        #endif
    }
}
