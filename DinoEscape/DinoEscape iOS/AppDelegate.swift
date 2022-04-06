//
//  AppDelegate.swift
//  DinoEscape iOS
//
//  Created by Felipe Leite on 07/03/22.
//
// swiftlint:disable line_length
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let dinos = SkinDataModel.shared.getSkins()
        if dinos .isEmpty {
            CreateCoreData.shared.create()
            UserDefaults.standard.set(true, forKey: "music")
            UserDefaults.standard.set(true, forKey: "vibration")
            UserDefaults.standard.set(true, forKey: "isFirstRun")
            
        }
        
        #warning("deletar coredata -> apenas para testes")
        // try! SkinDataModel.deleteCoreData(skins: dinos)
        return true
    }

}
