//
//  FavoriteCharacterEntity+CoreDataProperties.swift
//  marvel-challenge
//
//  Created by Danilo Henrique on 14/07/20.
//  Copyright © 2020 danilo. All rights reserved.
//
//

import Foundation
import CoreData


extension FavoriteCharacterEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteCharacterEntity> {
        return NSFetchRequest<FavoriteCharacterEntity>(entityName: "FavoriteCharacterEntity")
    }

    @NSManaged public var id: Int32
    @NSManaged public var image: Data?
    @NSManaged public var name: String?

}
