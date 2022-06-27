//
//  ViewModel.swift
//  Qeii
//
//  Created by 陈卓学 on 2022/6/27.
//

import Foundation

class ViewModel:ObservableObject {
    
    @Published var recordAmount = "0"  //record the amount being entered by the user currently
    
    @Published var showNotification = false
    
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
