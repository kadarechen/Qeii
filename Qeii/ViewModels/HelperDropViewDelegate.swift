//
//  HelperDropViewDelegate.swift
//  Qeii
//
//  Created by 陈卓学 on 2022/7/1.
//

import Foundation
import SwiftUI

struct HelperDropViewDelegate:DropDelegate {
    var model:ViewModel
    
    func performDrop(info: DropInfo) -> Bool {
        model.currentGrugingCate = nil
        return false
    }
    
    func dropUpdated(info: DropInfo) -> DropProposal? {
        return DropProposal(operation: .move)
    }
    
    func dropExited(info: DropInfo) {
        model.currentGrugingCate = nil
    }
}
