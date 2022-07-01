//
//  LaunchView.swift
//  Qeii
//
//  Created by 陈卓学 on 2022/6/26.
//

import SwiftUI

struct LaunchView: View {
    @EnvironmentObject var model:ViewModel
    
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "bag")
                }
            Text("RecordView")
                .tabItem {
                    Label("Entry", systemImage: "creditcard")
                }
            Text("Analysis")
                .tabItem {
                    Label("Analysis", systemImage: "dollarsign.circle")
                }
        }
//        .accentColor(Color(Constants.backgroundColor))
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
    }
}
