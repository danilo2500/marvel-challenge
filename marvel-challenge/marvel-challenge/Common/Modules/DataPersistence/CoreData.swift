//
//  CoreData.swift
//  marvel-challenge
//
//  Created by Danilo Henrique on 13/07/20.
//  Copyright © 2020 danilo. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {
    
    let appDelegate = UIApplication.shared.appDelegate
    lazy var managedContext = appDelegate.persistentContainer.viewContext
    
    func save(object: NSManagedObject, completion: (Error?) -> Void) {
        do {
            try managedContext.save()
            completion(nil)
        } catch let error as NSError {
            completion(error)
        }
    }
    
    func getAll<T: NSManagedObject>(entityName: String, completion: (Result<[T], Error>) -> Void) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        do {
            let results = try managedContext.fetch(fetchRequest) as! [T]
            completion(.success(results))
        } catch {
            completion(.failure(error))
        }
    }
    
    func get<T: NSManagedObject>(entityName: String, withId id: Int, completion: (Result<[T], Error>) -> Void) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "id = %d", id)
        do {
            let results = try managedContext.fetch(fetchRequest) as! [T]
            completion(.success(results))
        } catch {
            completion(.failure(error))
        }
    }
    
    func delete(object: NSManagedObject, completion: ((Error?) -> Void)?) {
        managedContext.delete(object)
        do {
            try managedContext.save()
            completion?(nil)
        } catch {
            completion?(error)
        }
    }
    
    func deleteAllEntries(entityName: String, completion: ((Error?) -> Void)?) {
        getAll(entityName: entityName) { (result) in
            switch result {
            case .success(let entities):
                for entity in entities {
                    delete(object: entity, completion: nil)
                }
                completion?(nil)
            case .failure(let error):
                completion?(error)
            }
        }
    }
}
