//
//  EditingHomeView.swift
//  Qeii
//
//  Created by 陈卓学 on 2022/7/1.
//

import SwiftUI

struct EditingHomeView: View {
    
    @EnvironmentObject var model: ViewModel
    
    @Binding var showEditingCategoriesView: Bool
    
    
    let columns = [GridItem(.flexible(), spacing: 0), GridItem(.flexible(), spacing: 0), GridItem(.flexible(), spacing: 0)]
    
    var body: some View {
        
        ZStack {
            switch model.editingHomeViewStatus {
            case .draging: Rectangle()
                    .foregroundColor(Color(Constants.trashBinColorWhenDraging))
                    .ignoresSafeArea()
                    .onDrop(of: [.url], delegate: trashBinDropViewDelegate(model: model))
            case .dragEnterTrashBin: Rectangle()
                    .foregroundColor(Color(Constants.trashBinColorWhenDragingEnter))
                    .ignoresSafeArea()
                    .onDrop(of: [.url], delegate: trashBinDropViewDelegate(model: model))
            default: Rectangle()
                    .foregroundColor(Color(Constants.normalTrashBinColor))
                    .ignoresSafeArea()
                    .onDrop(of: [.url], delegate: trashBinDropViewDelegate(model: model))
            
            }
            VStack {
                TrashBinView()
                    .onDrop(of: [.url], delegate: trashBinDropViewDelegate(model: model))
                
                ZStack {
                    Rectangle()
                        .foregroundColor(.white)
//                        .cornerRadius(27)
                        .ignoresSafeArea()
                    VStack {
                        
                        LazyVGrid(columns: columns, spacing: 0) {
                            ForEach(model.categoryManager!.list, id: \.self) { category in
                                CategoryGridView(category: category.category)
                            }
                                
       
                            
                        }
                        .padding([.top,.leading,.trailing], 7.5)
                        
                        HStack(spacing: 7.5) {
                            Button {
                                showEditingCategoriesView.toggle()
                            } label: {
                                ZStack {
                                    Rectangle()
                                        .frame(height: 45.0)
                                        .cornerRadius(10)
                                        .foregroundColor(Color(Constants.progressBarColorGray))
                                    Text("Cancel")
                                        .foregroundColor(.white)
                                        
                                }
                            }
                            
                            Button {
                                showEditingCategoriesView.toggle()
                            } label: {
                                ZStack {
                                    Rectangle()
                                        .frame(height: 45.0)
                                        .cornerRadius(10)
                                        .foregroundColor(Color(Constants.progressBarColor))
                                    Text("Save")
                                        .foregroundColor(.white)
                                        
                                }
                            }

                        }
                        .padding([.leading, .trailing], 7.5)
                        .padding([.top, .bottom], 15)
                        Spacer()
                    }
                }
                
                
                
            }
            
            
        }
    }
}

//struct EditingHomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditingHomeView()
//            .environmentObject(ViewModel())
//    }
//}



// MARK: - Discarded code, kept in reserve

//                    .onDrag {
//                        model.currentGrugingCate = category
//                        model.lastGrugingCate = category
//                        return NSItemProvider(contentsOf: URL(string: "http://www.google.com"))
//                    } preview: {
//                        ZStack {
//                        Rectangle()
//                            .frame(width: model.widthOfGridItem, height: 120)
//                            .foregroundColor(Color(Constants.categoryGridBGColor))
//                            .cornerRadius(16)
//                        VStack {
//                            Text(category.icon ?? "")
//                                .font(.system(size: 58))
//                            Text(category.title ?? "")
//                                .foregroundColor(Color(Constants.categoryTitleColor))
//                        }
//                        }
//                    }

struct TrashBinView: View {
    
    @EnvironmentObject var model:ViewModel
    
    var body: some View {
        HStack(spacing: 0){
            Image(systemName: "trash")
                .font(.system(size: 30))
                .padding([.top, .bottom], 3)

            switch model.editingHomeViewStatus {
            case .trashBinTapped: Text("Long press on a category and drag it here to delete it. ").padding([.leading], 10)
            case .draging: Text("Drag here to delete the category. ").padding([.leading], 10)
            case .dragEnterTrashBin: Text("Release to delete. ").padding([.leading], 10)
            case .normal: Text("").frame(width: 0, height: 0)
            }
        }
        .padding()
        .foregroundColor(.white)
        .onTapGesture {
            withAnimation {
                model.editingHomeViewStatus = .trashBinTapped
            }
            model.trashBinWiggle = true
            Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { (timer) in
                model.trashBinWiggle = false
            }
            Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { (timer) in
                if model.editingHomeViewStatus == .trashBinTapped {
                    withAnimation {
                        model.editingHomeViewStatus = .normal
                    }
                }
            }
        }
    }
}

struct CategoryGridView: View {
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
