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
        let icons = ["🥘","🍩","☕️","🚌", "📖", "💻"]
        let title = ["Regular", "Snacks", "Coffee", "Transport", "Books", "Extra"]
        for i in 0..<icons.count {
            let category = Category(context: CoreDataManager.shared.viewContext)
            category.title = title[i]
            category.icon = icons[i]
            category.timestamp = Date.now
            category.valid = true
            category.sorting = Int64(i)
            
            
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
        let sort = NSSortDescriptor(key: "sorting", ascending: true)
        request.sortDescriptors = [sort]
        do {
            let results = try viewContext.fetch(request)
//            viewContext.reset()
            return results
        } catch {
            print("Fetch all categories error! ")
            return []
        }
    }
    
    func addRecord(amount: Double, category:Category, note: String) {
        let record = Record(context: CoreDataManager.shared.viewContext)
        record.category = category
        record.note = note
        record.amount = amount
        
        save()
    }
}
