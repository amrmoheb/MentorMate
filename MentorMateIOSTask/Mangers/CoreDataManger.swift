

import Foundation
import CoreData

class CoreDataManager {
    
    let persistentContainer: NSPersistentContainer
    
    static let shared = CoreDataManager()
    
    private init() {
        
        persistentContainer = NSPersistentContainer(name: "VenueModel")
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Failed to initialize Core Data \(error)")
            }
        }
    }
   
    func getCachedVenues() -> [Venue] {

        let fetchRequest: NSFetchRequest<Venue> = Venue.fetchRequest()
        
        do {
            return try persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            return []
        }
        
    }
    func deleteAllVenuesData() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Venue")
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let results = try persistentContainer.viewContext.fetch(fetchRequest)
            for object in results {
                guard let objectData = object as? NSManagedObject else {continue}
                persistentContainer.viewContext.delete(objectData)
            }
        } catch let error {
            print("Detele all data in Venue error :", error)
        }
        do {
            try persistentContainer.viewContext.save()
        } catch {
            persistentContainer.viewContext.rollback()
            print("Failed to save after delete All Venues Data \(error)")
        }
    }
    func save() {
        do {
            try persistentContainer.viewContext.save()
        } catch {
            print("Failed to save  \(error)")
        }
    }
}
