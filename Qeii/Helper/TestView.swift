//
//  TestView.swift
//  Qeii
//
//  Created by 陈卓学 on 2022/6/26.
//

import SwiftUI
import PopupView

struct TestView: View {
    
    @State var a = CGRect()
    @State var b = EdgeInsets()
    
    
    var body: some View {
        GeometryReader { geo in
            
        }
        .onAppear {
//            self.frameGetter($a, $b)
            print(a.width)
        }
            
    }
}

//struct TestView_Previews: PreviewProvider {
//    static var previews: some View {
//        TestView()
//    }
//}
