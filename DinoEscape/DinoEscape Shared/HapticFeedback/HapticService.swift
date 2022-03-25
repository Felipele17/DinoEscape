//
//  HapticService.swift
//  DinoEscape
//
//  Created by Beatriz Duque on 25/03/22.
//

import Foundation
import CoreHaptics

class HapticService{
    static let shared = HapticService()
    let engine = try? CHHapticEngine()
    
    
    func getUserDefaultsStatus() -> Bool {
        return UserDefaults.standard.bool(forKey: "vibration")
    }
    func updateUserDefaults() -> Bool {
        var vibration = UserDefaults.standard.bool(forKey: "vibration")
        vibration.toggle()
        UserDefaults.standard.setValue(vibration, forKey: "vibration")
        return self.getUserDefaultsStatus()
    }
    
    func addVibration(){
        if UserDefaults.standard.bool(forKey: "vibration"){
            guard let url = Bundle.main.url(forResource: "haptic",
                                            withExtension: "json") else {
                        
                print("could not load file")
                        
                return
                }
                    
                do {
                    try engine?.playPattern(from: url)
                } catch {
                    print("play error: \(error)")
                }
        }
        else {
            print("vribracao desativada")
        }
        
    }
}
