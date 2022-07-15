//
//  CategoriesEditModeContainer.swift
//  Qeii
//
//  Created by 陈卓学 on 15/07/2022.
//

import Foundation

struct CategoriesEditModeContainerManager {
    var list: [CategoriesEditModeContainer]

}

struct CategoriesEditModeContainer:Hashable {
    var category: Category
    var isDeletedTemp = false
    
    init(_ category: Category) {
        self.category = category
    }
}
