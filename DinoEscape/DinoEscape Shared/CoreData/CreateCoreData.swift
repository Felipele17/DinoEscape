//
//  CreateCoreData.swift
//  DinoEscape
//
//  Created by Beatriz Duque on 21/03/22.
//

import Foundation
import CoreData

class CreateCoreData {
    static var shared = CreateCoreData()
    
    let dinos = ["t-Rex","brachiosaurus","chickenosaurus","stegosaurus","triceratops"]
    func create(){
        for dino in dinos{
            _ = try! SkinDataModel.createSkin(name: dino,
                                                   image: dino,
                                                   isSelected: false,
                                                   isBought: false)
        }
        
        //setando o rex
        let dinos = try! SkinDataModel.getSkins()
        var rex = dinos[0]
        rex = try! SkinDataModel.buyDino(skin: rex)
        rex = try! SkinDataModel.selectSkin(skin: rex)
    }
}