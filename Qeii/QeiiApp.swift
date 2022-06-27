//
//  QeiiApp.swift
//  Qeii
//
//  Created by 陈卓学 on 2022/6/26.
//

import SwiftUI

@main
struct QeiiApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
            LaunchView()
                .environmentObject(ViewModel())
        }
    }
}
