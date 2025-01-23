//
//  CoreDataManager.swift
//  Spotify
//
//  Created by Dwistari on 17/01/25.
//

import CoreData


class CoreDataManager {
    static let shared = CoreDataManager()
    let persistentContainer: NSPersistentContainer

    private init() {
           persistentContainer = NSPersistentContainer(name: "Spotify")
           persistentContainer.loadPersistentStores { _, error in
               if let error = error {
                   fatalError("Failed to load Core Data stack: \(error)")
               }
           }
       }
    
    var context: NSManagedObjectContext {
          persistentContainer.viewContext
      }
      
    func saveContext() {
         if context.hasChanges {
             do {
                 try context.save()
             } catch {
                 let nserror = error as NSError
                 fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
             }
         }
     }
    
}
