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
    
    func addVibration(haptic: String){
        if UserDefaults.standard.bool(forKey: "vibration"){
            guard let url = loadJson(forFilename: haptic) else {
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
            print("vibracao desativada")
        }
        
    }
    
    func loadJson(forFilename fileName: String) -> URL? {

        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            return url
        }
        print("error")
        return nil
    }
}


