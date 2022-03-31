//
//  SkinData.swift
//  DinoEscape
//
//  Created by Beatriz Duque on 21/03/22.
//

import Foundation
import CoreData

class SkinDataModel {
    
    static var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores{ _, error in
            if let erro = error {
                preconditionFailure(erro.localizedDescription)
            }
            
        }
        return container
    }()
    
    static var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    // salvar
    static func saveContext() throws{
        if context.hasChanges{
            try context.save()
        }
    }
    
    // criar Skin
    static func createSkin(name: String, image: String, isSelected: Bool, isBought: Bool, price: Int32) throws -> SkinData {
        guard let skin =  NSEntityDescription.insertNewObject(forEntityName: "SkinData", into: context) as? SkinData else {preconditionFailure()}
        skin.name = name
        skin.image = image
        skin.isSelected = isSelected
        skin.isBought = isBought
        skin.price = price
        try saveContext()
        return skin
    }
    // editar skin
    static func buyDino(skin: SkinData) throws -> SkinData{
        skin.isBought = true
        try saveContext()
        return skin
    }
    static func selectSkin(skin: SkinData) throws -> SkinData{
        //setando skin antiga como nao-selecionada
        let oldSkin = getSkinSelected()
        oldSkin.isSelected = false
        
        //nova skin como selecionada
        skin.isSelected = true
        try saveContext()
        return skin
    }
    // pesquisar Skin
    static func getSkins() throws -> [SkinData] {
        return try context.fetch(SkinData.fetchRequest())
    }
    
    static func getSkinSelected() -> SkinData {
        let dinos = try! self.getSkins()
        for i in 0..<dinos.count{
            if dinos[i].isSelected == true{
                return dinos[i]
            }
        }
        return dinos[0]
    }
    
    //deletar
    static func deleteSkin(skin: SkinData) throws {
        context.delete(skin)
        try saveContext()
    }
}
