//
//  CoreDataManager.swift
//  news
//
//  Created by Barış Dilekçi on 29.05.2025.
//


import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()

    private init() {}

    // MARK: - Core Data Stack

    lazy var persistentContainer: NSPersistentContainer = {
     
        let container = NSPersistentContainer(name: "news") 
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
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

    // MARK: - Helper to get context
    func getContext() -> NSManagedObjectContext {
        return persistentContainer.viewContext
    }
}
