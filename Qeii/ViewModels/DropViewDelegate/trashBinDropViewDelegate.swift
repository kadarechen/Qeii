//
//  trashBinDropViewDelegate.swift
//  Qeii
//
//  Created by 陈卓学 on 2022/7/2.
//

import Foundation
import SwiftUI

struct trashBinDropViewDelegate: DropDelegate {
    
    var model: ViewModel
    
    func performDrop(info: DropInfo) -> Bool {
        //TODO: delete category
        
        model.currentGrugingCate = nil
        withAnimation {
            model.editingHomeViewStatus = .normal
        }
        
        return true
    }
    
    func dropEntered(info: DropInfo) {
        withAnimation {
            model.editingHomeViewStatus = .dragEnterTrashBin
        }
        
    }
    func dropExited(info: DropInfo) {
        withAnimation {
            model.editingHomeViewStatus = .draging
        }
        
    }
    func dropUpdated(info: DropInfo) -> DropProposal? {
        return DropProposal(operation: .move)
    }
    
}
