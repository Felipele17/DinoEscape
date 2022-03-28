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
    let dinos = ["t-Rex","brachiosaurus","chickenosaurus","stegosaurus","triceratops","veloci"]
    let images = ["frameTrex","frameBraci","frameChicken","frameSte", "frameTrice","frameVeloci"]
    let prices = [0,10,100000,10,10,10]
    func create(){
        for i in 0..<dinos.count{
            _ = try! SkinDataModel.createSkin(name: dinos[i],
                                                   image: images[i],
                                                   isSelected: false,
                                                   isBought: false,
                                                    price: Int16(prices[i]))
        }
        
        //setando o rex
        let dinos = try! SkinDataModel.getSkins()
        var rex = dinos[0]
        rex = try! SkinDataModel.buyDino(skin: rex)
        rex = try! SkinDataModel.selectSkin(skin: rex)
    }
}
