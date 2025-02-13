//
//  Persistence.swift
//  ToDoCrew
//
//  Created by Petar  on 12.2.25..
//

import CoreData

struct PersistenceController {
    
    //MARK: - Properties
    static let shared = PersistenceController()
    
    @MainActor
    static let preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for _ in 0..<10 {
            let newItem = Todo(context: viewContext)
            newItem.id = UUID()
            newItem.name = ""
            newItem.priority = ""
        }
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            assertionFailure("Unresolved error: \(error.localizedDescription)")
        }
        return result
    }()
    
    let container: NSPersistentContainer
    
    //MARK: - Init
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "ToDoCrew")
        if inMemory {
            if let storeDescription = container.persistentStoreDescriptions.first {
                storeDescription.url = URL(fileURLWithPath: "/dev/null")
            } else {
                assertionFailure("Failed to get persistentStoreDescriptions")
            }
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
