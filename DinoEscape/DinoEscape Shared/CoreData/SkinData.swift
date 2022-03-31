//
//  SkinData.swift
//  DinoEscape
//
//  Created by Beatriz Duque on 21/03/22.
//

import Foundation
import CoreData

class SkinDataModel {
    
    static let shared: SkinDataModel = SkinDataModel()
    
    var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores { _, error in
            if let erro = error {
                preconditionFailure(erro.localizedDescription)
            }
            
        }
        return container
    }()
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    // salvar
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // criar Skin
    func createSkin(name: String, image: String, isSelected: Bool, isBought: Bool, price: Int32) -> SkinData {
        guard let skin =  NSEntityDescription.insertNewObject(forEntityName: "SkinData",
                                                              into: context) as? SkinData else {preconditionFailure()}
        skin.name = name
        skin.image = image
        skin.isSelected = isSelected
        skin.isBought = isBought
        skin.price = price
        saveContext()
        return skin
    }
    // editar skin
    func buyDino(skin: SkinData) -> SkinData{
        skin.isBought = true
        saveContext()
        return skin
    }
    func selectSkin(skin: SkinData) -> SkinData{
        // setando skin antiga como nao-selecionada
        let oldSkin = getSkinSelected()
        oldSkin.isSelected = false
        
        // nova skin como selecionada
        skin.isSelected = true
        self.saveContext()
        return skin
    }
    // pesquisar Skin
    func getSkins() -> [SkinData] {
        let fetchRequest = NSFetchRequest<SkinData>(entityName: "SkinData")
        do {
            return try self.persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            print(error)
        }
        
        return []
    }
    
    func getSkinSelected() -> SkinData {
        let dinos = self.getSkins()
        for index in 0..<dinos.count where dinos[index].isSelected == true {
                return dinos[index]
        }
        return dinos[0]
    }
    
    // deletar
    func deleteSkin(skin: SkinData) throws {
        context.delete(skin)
        self.saveContext()
    }
    
    func deleteCoreData(skins: [SkinData]) throws {
        for dino in skins {
            context.delete(dino)
            self.saveContext()
        }
    }
}
