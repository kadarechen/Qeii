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
        print("set to nil")
        return true
    }
    
    func dropEntered(info: DropInfo) {
        
        model.currentGrugingCate = model.lastGrugingCate
        
        let fromIndex = model.categories.firstIndex { category in
            return category.title == model.currentGrugingCate?.title
        } ?? 0
        
        let toIndex = model.categories.firstIndex { category in
            return category.title == self.category.title
        } ?? 0
        
        if fromIndex != toIndex {
//            withAnimation {
//                let temp = model.categories[fromIndex]
//                model.categories[fromIndex] = model.categories[toIndex]
//                model.categories[toIndex] = temp
//            }
            if fromIndex < toIndex {
                withAnimation {
                let temp = model.categories[fromIndex]
                for i in fromIndex..<toIndex {
                    model.categories[i] = model.categories[i+1]
                }
                model.categories[toIndex] = temp
                }
            } else {
                withAnimation {
                let temp = model.categories[fromIndex]
                for i in (toIndex+1...fromIndex).reversed() {
                    model.categories[i] = model.categories[i-1]
                }
                model.categories[toIndex] = temp
                }
            }
        }
    }
    
    func dropUpdated(info: DropInfo) -> DropProposal? {
        return DropProposal(operation: .move)
    }
    
}
