//
//  Keyboard.swift
//  Qeii
//
//  Created by 陈卓学 on 2022/6/26.
//

import SwiftUI

struct Keyboard: View {
    
    @EnvironmentObject var model:ViewModel
    
    var gridItems = [GridItem(.flexible(),spacing: 5), GridItem(.flexible(), spacing: 5), GridItem(.flexible(),spacing: 5), GridItem(.flexible(),spacing: 5)]
    var calculateNum = "123d4560789+".map{String($0)}
    
    var body: some View {
        LazyVGrid(columns: gridItems, spacing: 5) {
            ForEach(calculateNum, id: \.self) { symbol in
                Button {
                    model.AddRecordNumButtonPressed(with: symbol)
                } label: {
                    if symbol == "d" {
                        ZStack {
                                                Rectangle()
                                                    .frame(height: 55)
                                                    .foregroundColor(Color(Constants.categoryGridBGColor))
                                                Image(systemName: "delete.left")
                                                    .foregroundColor(Color(Constants.progressBarColor))
                                            }
                    } else {
                        ZStack {
                                                Rectangle()
                                                    .frame(height: 55)
                                                    .foregroundColor(Color(Constants.categoryGridBGColor))
                                                Text(symbol)
                                                    .foregroundColor(Color(Constants.progressBarColor))
                                            }
                    }
                    
                }
            }
        }
    }
}

struct Keyboard_Previews: PreviewProvider {
    static var previews: some View {
        Keyboard()
    }
}
