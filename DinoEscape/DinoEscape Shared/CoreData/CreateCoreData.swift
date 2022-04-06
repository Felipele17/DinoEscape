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
    let dinos = ["t-Rex", "brachiosaurus", "chickenosaurus", "stegosaurus", "triceratops", "veloci"]
    let images = ["frameTrex", "frameBraci", "frameChicken", "frameSte", "frameTrice", "frameVeloci"]
    let prices = [0, 1000, 100_000, 1000, 1000, 1000]
    func create() {
        for index in 0..<dinos.count {
            _ = SkinDataModel.shared.createSkin(name: dinos[index],
                                                image: images[index],
                                                isSelected: false,
                                                isBought: false,
                                                price: Int32(prices[index]))
        }
        
        // setando o rex
        let dinos = SkinDataModel.shared.getSkins()
        var rex = dinos[0]
        rex = SkinDataModel.shared.buyDino(skin: rex)
        rex = SkinDataModel.shared.selectSkin(skin: rex)
    }
}
