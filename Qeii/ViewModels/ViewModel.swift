//
//  ViewModel.swift
//  Qeii
//
//  Created by 陈卓学 on 2022/6/27.
//

import Foundation
import CoreData

class ViewModel:ObservableObject {
    
    
    
    let firstRun = UserDefaults.standard.bool(forKey: "firstRun") as Bool
    
    @Published var recordAmount = "0"  //record the amount being entered by the user currently
    
    @Published var showNotification = false
    
    @Published var categories = [Category]()
    
    @Published var widthOfGridItem = 0.0
    
    init() {
        if firstRun {
            
        } else {
            runFirst()
        }
    }
    
    func runFirst() {
        print("FIRST RUN!")
        
        //load default categories data
        CoreDataManager.shared.createDefaultCategories()
        
        UserDefaults.standard.set(true, forKey: "firstRun")
    }
    
    func fetchAllCategories() {
        categories =  CoreDataManager.shared.fetchAllCategories()
    }
    
    func AddRecordNumButtonPressed(with symbol: String) {
        if symbol == "+" || symbol == "-" {
            //TODO: call Calculate
        } else {
            if recordAmount == "0" {
                recordAmount = symbol
            } else {
                recordAmount = recordAmount + symbol
            }
        }
    }
    
    func addRecord() {
        showNotification = true
        Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { (timer) in
            self.showNotification = false
        }
        //TODO: add record - waiting for coredata implimentation
    }
}

//struct CategoryViewModel {
//
//    let category: Category
//
//    var id:
//
//    var title
//}
