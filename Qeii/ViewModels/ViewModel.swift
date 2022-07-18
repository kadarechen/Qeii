//
//  ViewModel.swift
//  Qeii
//
//  Created by 陈卓学 on 2022/6/27.
//

import Foundation
import CoreData

enum pageStatus {
    case normal
    case trashBinTapped
    case draging
    case dragEnterTrashBin
}

class ViewModel:ObservableObject {
    
    // MARK: - systom overall
    
    let firstRun = UserDefaults.standard.bool(forKey: "firstRun") as Bool
    @Published var categories = [Category]()
    var extraCategory:Category?
    
    // MARK: - Information of record currently being added
    @Published var recordAmount = "0"  //record the amount being entered by the user currently
    @Published var note = ""
    @Published var category:Category?
    @Published var showNotification = false
    @Published var categoryManager: CategoriesEditModeContainerManager?
    
    // MARK: - view frame
    @Published var widthOfGridItem = 0.0
    
    // MARK: - drag&drop
    @Published var currentGrugingCate: Category?
    @Published var lastGrugingCate: Category?
    @Published var editingHomeViewStatus = pageStatus.normal
    @Published var trashBinWiggle = false
    var attempts = false
    
    func wiggleDifferenciator() -> Double{
        attempts.toggle()
        if attempts {
            return 4.0
        } else {
            return -4.0
        }
    }
    
    init() {
        if firstRun {
            
        } else {
            runFirst()
        }
        fetchAllCategories()
        fetchAllEntries()
    }
    
    
    // MARK: - onload
    
    func runFirst() {
        print("FIRST RUN!")
        
        //load default categories data
        CoreDataManager.shared.createDefaultCategories()
        
        UserDefaults.standard.set(true, forKey: "firstRun")
    }
    
    func fetchAllCategories() {
        categories =  CoreDataManager.shared.fetchAllCategories()
        for category in categories {
            if category.title == "Extra" {
                extraCategory = category
            }
        }
//        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
//        print(paths[0])
    }
    
    func fetchAllEntries() {
        
    }
    
    // MARK: - others
    
    func addRecordButtonPressed(category:Category) {
        let amount = Double(recordAmount)!
        CoreDataManager.shared.addRecord(amount: amount, category: category, note: note)
        recordAmount = "0"
        note = ""
    }
    
    func AddRecordNumButtonPressed(with symbol: String) {
        if symbol == "+" || symbol == "-" {
            //TODO: call Calculate
        } else if symbol == "d" {
            if recordAmount != "0" {
                recordAmount.removeLast()
                if recordAmount == "" {
                    recordAmount = "0"
                }
            }
        } else {
            if recordAmount == "0" {
                recordAmount = symbol
            } else {
                recordAmount = recordAmount + symbol
            }
        }
    }
    
    // Run when 'addRecord' button pressed
    func addRecord() {
        showNotification = true
        Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { (timer) in
            self.showNotification = false
        }
        
        let amount = Double(recordAmount)!
        CoreDataManager.shared.addRecord(amount: amount, category: category!, note: note)
        recordAmount = "0"
        note = ""
        
        //TODO: update entry view
    }
    
    func cleanAmount() {
        recordAmount = "0"
    }
    
    func prepareForCategoriesEditing() {
        var list = [CategoriesEditModeContainer]()
        for i in 0..<categories.count {
            let container = CategoriesEditModeContainer(categories[i])
            list.append(container)
        }
        categoryManager = CategoriesEditModeContainerManager(list: list)
    }
}

