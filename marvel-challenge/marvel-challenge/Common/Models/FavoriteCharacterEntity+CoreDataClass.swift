//
//  FavoriteCharacterEntity+CoreDataClass.swift
//  marvel-challenge
//
//  Created by Danilo Henrique on 14/07/20.
//  Copyright © 2020 danilo. All rights reserved.
//
//
import UIKit
import CoreData

@objc(FavoriteCharacterEntity)
public class FavoriteCharacterEntity: NSManagedObject {
    convenience init() {
        let appDelegate = UIApplication.shared.appDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        self.init(context: managedContext)
    }
}
