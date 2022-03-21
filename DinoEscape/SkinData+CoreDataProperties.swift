//
//  SkinData+CoreDataProperties.swift
//  DinoEscape
//
//  Created by Beatriz Duque on 21/03/22.
//
//

import Foundation
import CoreData


extension SkinData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SkinData> {
        return NSFetchRequest<SkinData>(entityName: "SkinData")
    }

    @NSManaged public var isSelected: Bool
    @NSManaged public var name: String?
    @NSManaged public var isBought: Bool
    @NSManaged public var image: String?

}

extension SkinData : Identifiable {

}
