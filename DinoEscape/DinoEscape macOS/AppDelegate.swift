//
//  AppDelegate.swift
//  DinoEscape macOS
//
//  Created by Felipe Leite on 07/03/22.
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {



    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        let dinos = try! SkinDataModel.getSkins()
        if dinos.count == 0 {
            CreateCoreData.shared.create()
        }
//        print("rex",dinos[0].image)
//        print("rex",dinos[0].isBought)
//        print("rex",dinos[0].isSelected)

        
        for dino in dinos{
            try! SkinDataModel.deleteSkin(skin: dino)
        }
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }


}

