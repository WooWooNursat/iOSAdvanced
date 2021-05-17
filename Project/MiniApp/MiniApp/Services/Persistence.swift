//
//  Persistence.swift
//  MiniApp
//
//  Created by Nursat on 12.05.2021.
//

import Foundation
import CoreData

class PersistenceController {
    static let shared = PersistenceController()
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "MiniCoreData")
        
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error: \(error)")
            }
        }
    }
}
