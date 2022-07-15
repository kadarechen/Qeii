//
//  CategoriesSortDropViewDelegate.swift
//  Qeii
//
//  Created by 陈卓学 on 2022/7/1.
//

import Foundation
import SwiftUI

struct CategoriesSortDropViewDelegate: DropDelegate {
    
    var category: Category
    var model: ViewModel
    
    func performDrop(info: DropInfo) -> Bool {
        model.currentGrugingCate = nil
        withAnimation {
            model.editingHomeViewStatus = .normal
        }
        print("set to nil")
        return true
    }
    
    func dropEntered(info: DropInfo) {
        
        model.currentGrugingCate = model.lastGrugingCate
        
        var fromIndex = 0
        var toIndex = 0
        
        for i in 0..<model.categoryManager!.list.count {
            if model.categoryManager!.list[i].category.title == model.currentGrugingCate?.title {
                fromIndex = i
            } else if model.categoryManager!.list[i].category.title == category.title {
                toIndex = i
            }
        }
        
        
        if fromIndex != toIndex {
            if fromIndex < toIndex {
                withAnimation {
                let temp = model.categoryManager!.list[fromIndex]
                for i in fromIndex..<toIndex {
                    model.categoryManager!.list[i] = model.categoryManager!.list[i+1]
                }
                model.categoryManager!.list[toIndex] = temp
                }
            } else {
                withAnimation {
                let temp = model.categoryManager!.list[fromIndex]
                for i in (toIndex+1...fromIndex).reversed() {
                    model.categoryManager!.list[i] = model.categoryManager!.list[i-1]
                }
                model.categoryManager!.list[toIndex] = temp
                }
            }
        }
    }
    
    func dropUpdated(info: DropInfo) -> DropProposal? {
        return DropProposal(operation: .move)
    }
    
}
