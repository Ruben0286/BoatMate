//
//  Persistence.swift
//  BoatMate
//
//  Created by Ruben Förstmann on 10.08.25.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    @MainActor
    static let preview: PersistenceController = {
        let controller = PersistenceController(inMemory: true)
        let ctx = controller.container.viewContext

        // Prüfen, ob schon Boote existieren
        let request: NSFetchRequest<Boat> = Boat.fetchRequest()
        request.fetchLimit = 1
        let existingCount = (try? ctx.count(for: request)) ?? 0

        if existingCount == 0 {
            // Seed nur einmal, wenn leer
            for name in ["Aurora", "Mistral", "Nordlicht"] {
                let boat = Boat(context: ctx)
                boat.name = name
            }
            try? ctx.save()
        }

        return controller
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "BoatMate")

        if inMemory {
            let desc = NSPersistentStoreDescription()
            desc.type = NSInMemoryStoreType
            container.persistentStoreDescriptions = [desc]
        } else {
            let desc = NSPersistentStoreDescription()
            desc.type = NSSQLiteStoreType
            // 🔑 Lightweight Migration aktivieren:
            desc.setOption(true as NSNumber, forKey: NSMigratePersistentStoresAutomaticallyOption)
            desc.setOption(true as NSNumber, forKey: NSInferMappingModelAutomaticallyOption)
            container.persistentStoreDescriptions = [desc]
        }

        container.loadPersistentStores { _, error in
            precondition(error == nil, "Core Data store failed \(error!)")
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    }
}

