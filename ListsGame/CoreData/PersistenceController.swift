//
//  PresistenceController.swift
//  ListsGame
//
//  Created by irfan wahendra on 26/04/25.
//

import CoreData

struct PersistenceController {
  static let shared = PersistenceController()
  
  let container: NSPersistentContainer
  
  init(inMemory: Bool = false) {
    container = NSPersistentContainer(name: "SavedGameModel")
    if inMemory {
      container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
    }
    container.loadPersistentStores { description, error in
      if let error = error {
        fatalError("Unresolved error \(error)")
      }
    }
  }
}
