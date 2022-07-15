//
//  TestView.swift
//  Qeii
//
//  Created by 陈卓学 on 15/07/2022.
//

import SwiftUI

struct TestView: View {
    @EnvironmentObject var model: ViewModel
    
    let columns = [GridItem(.flexible(), spacing: 0), GridItem(.flexible(), spacing: 0), GridItem(.flexible(), spacing: 0)]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 0) {
            ForEach(model.categoryManager!.list, id: \.self) { category in
                ExtractedView(category: category.category)
            }
            
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}

struct ExtractedView: View {
    var category: Category
    @EnvironmentObject var model: ViewModel
    
    var body: some View {
        ZStack {
            
            Rectangle()
                .stroke(style: StrokeStyle(lineWidth: 1.5, dash: [5]))
                .frame(width: model.widthOfGridItem + 15, height: 135)
                .foregroundColor(.black)
            ZStack {
                Rectangle()
                    .frame(width: model.widthOfGridItem, height: 120)
                    .foregroundColor(Color(Constants.categoryGridBGColor))
                    .cornerRadius(16)
                VStack {
                    Text(category.icon ?? "")
                        .font(.system(size: 58))
                    Text(category.title ?? "")
                        .foregroundColor(Color(Constants.categoryTitleColor))
                }
            }
            .opacity(model.currentGrugingCate?.title == category.title ? 0.01 : 1)
            .onDrag{
                model.currentGrugingCate = category
                model.lastGrugingCate = category
                withAnimation {
                    model.editingHomeViewStatus = .draging
                }
                
                return NSItemProvider()
            }
            .rotationEffect(.degrees(model.trashBinWiggle ? model.wiggleDifferenciator() : 0))
            .animation(model.trashBinWiggle ? Animation.default.repeatCount(7, autoreverses: true).speed(5) : Animation.default.repeatCount(1, autoreverses: false).speed(1))
        }
        .onDrop(of: [.url], delegate: CategoriesSortDropViewDelegate(category: category, model: model))
        .gesture(DragGesture().onEnded({ value in
            model.currentGrugingCate = nil
        }))
        .onTapGesture {
            model.currentGrugingCate = nil
        }
    }
}
