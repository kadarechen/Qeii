//
//  CoreDataManager.swift
//  Qeii
//
//  Created by 陈卓学 on 2022/6/28.
//

import Foundation
import CoreData

class CoreDataManager {
    
    let persistentContainer: NSPersistentContainer
    static let shared = CoreDataManager()
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "Qeii")
        persistentContainer.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Unable to initialize Core Data Stack \(error)")
            }
        }
    }
    
    func createDefaultCategories() {
        let icons = ["🥘","🍩","☕️","🚌", "📖"]
        let title = ["Regular", "Snacks", "Coffee", "Transport", "Books"]
        for i in 0...4 {
            let category = Category(context: CoreDataManager.shared.viewContext)
            category.title = title[i]
            category.icon = icons[i]
            category.timestamp = Date.now
            category.valid = true
            category.sorting = 0 //temp
            
            
            CoreDataManager.shared.save()
        }
    }
    
    func save() {
        do {
            try viewContext.save()
        } catch {
            viewContext.rollback()
            print(error.localizedDescription)
            print("save error")
        }
    }
    
    func fetchAllCategories() -> [Category] {
        let request: NSFetchRequest<Category> = Category.fetchRequest()
        do {
            return try viewContext.fetch(request)
        } catch {
            print("Fetch all categories error! ")
            return []
        }
    }
}
