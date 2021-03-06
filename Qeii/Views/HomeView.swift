//
//  HomeView.swift
//  Qeii
//
//  Created by 陈卓学 on 2022/6/26.
//

import SwiftUI
import PopupView

struct HomeView: View {
    
    @EnvironmentObject var model:ViewModel
    
    @State var showAddRecordView = false
    @State var showEditingCategoriesView = false
    @State var showTestView = false
    
    
    let columns = [GridItem(.flexible(), spacing: 15), GridItem(.flexible(), spacing: 15), GridItem(.flexible(), spacing: 15)]
    
    
    var body: some View {
        GeometryReader { _ in
            ZStack(alignment: .top) {
                Rectangle()
                    .frame(height: 500.0)
                    .ignoresSafeArea()
                    .foregroundColor(Color(Constants.backgroundColor))
                VStack {
                    HStack(alignment: .bottom) {
                        Text("Expenditure")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        Spacer()
                        Text("156.38")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                    .padding([.top, .leading, .trailing])
                    
                    HStack {
                        Text("for the month")
                            .font(.body)
                            .foregroundColor(.white)
                        Spacer()
                        
                        Button {
                            
                        } label: {
                            Text("Budget: 300")
                                .font(.body)
                                .foregroundColor(.white)
                            Image(systemName: Constants.budgetModifer)
                                .font(.body)
                                .foregroundColor(.white)
                        }
                        
                    }
                    .padding(.horizontal)
                    
                    ZStack(alignment: .leading) {
                        Capsule()
                        
                            .frame(height: 22.0)
                            .foregroundColor(Color(Constants.progressBarColorGray))
                        Capsule()
                            .frame(width: 180.0, height: 22.0)
                            .foregroundColor(Color(Constants.progressBarColor))
                        
                    }
                    .padding(.horizontal)
                    
                    ZStack(alignment: .top) {
                        Rectangle()
                            .foregroundColor(.white)
                            .cornerRadius(27)
                        VStack(spacing: 0.0) {
                            LazyVGrid(columns: columns, spacing: 15) {
                                ForEach(model.categories, id: \.self) {category in
                                    if category.title != "" {
                                        Button{
                                            model.category = category
                                            showAddRecordView = true
                                        } label: {
                                            ZStack {
                                                Rectangle()
                                                    .frame(height: 120)
                                                    .foregroundColor(Color(Constants.categoryGridBGColor))
                                                    .cornerRadius(16)
                                                VStack {
                                                    Text(category.icon ?? "")
                                                        .font(.system(size: 58))
                                                    Text(category.title ?? "")
                                                        .foregroundColor(Color(Constants.categoryTitleColor))
                                                }
                                            }
                                            .readSize { size in
                                                model.widthOfGridItem = size.width
                                            }
                                            .opacity(model.currentGrugingCate?.title == category.title ? 0.01 : 1)
                                            
                                        }
                                        .gesture(DragGesture().onEnded({ value in
                                            model.currentGrugingCate = nil
                                        }))
                                        .onDrag{
                                            model.currentGrugingCate = category
                                            model.lastGrugingCate = category
                                            return NSItemProvider()
                                        }
                                        .onDrop(of: [.url], delegate: CategoriesSortDropViewDelegate(category: category, model: model))
                                    }
                                    
                                }
                                
                            }
                            .padding([.top,.leading,.trailing])
                            
                            Button{
                                model.category = model.extraCategory
                                showAddRecordView = true
                            } label: {
                                ZStack(alignment: .leading) {
                                    Rectangle()
                                        .frame(height: 120)
                                        .foregroundColor(Color(Constants.categoryGridBGColor))
                                        .cornerRadius(16)
                                    HStack {
                                        ZStack {
                                            Rectangle()
                                                .frame(width: model.widthOfGridItem, height: 120)
                                                .foregroundColor(Color(Constants.categoryGridBGColor))
                                                .cornerRadius(16)
                                            
                                            VStack {
                                                Text("💻")
                                                    .font(.system(size: 58))
                                                Text("Extra")
                                                    .foregroundColor(Color(Constants.categoryTitleColor))
                                            }
                                            
                                            
                                        }
                                        Text("Add a record that is not counted in the monthly expense analysis view. ")
                                            .font(.body)
                                            .padding()
                                            .foregroundColor(.gray)
                                    }
                                }
                                .padding(.horizontal)
                                .padding(.top, 15.0)
                            }
                            
                            Button{
                                model.prepareForCategoriesEditing()
                                showEditingCategoriesView = true
                            } label: {
                                Image(systemName: "pencil.circle.fill")
                                    .font(.system(size: 35))
                                    .padding()
                            }
                            
                            Button{
                                model.prepareForCategoriesEditing()
                                showTestView = true
                            } label: {
                                Text("show test")
                            }
                        }
                        
                    }
                    .padding(.top)
                    
                    
                    Spacer()
                }
                .ignoresSafeArea(.all, edges: .bottom)
            }
            .popover(isPresented: $showAddRecordView) {
                AddRecordView(showAddRecordView: $showAddRecordView)
            }
            .popover(isPresented: $showTestView, content: {
                TestView()
            })
            .fullScreenCover(isPresented: $showEditingCategoriesView) {
                EditingHomeView(showEditingCategoriesView: $showEditingCategoriesView)
            }
            
        }.ignoresSafeArea(.keyboard, edges: .bottom)
            .popup(isPresented: $model.showNotification,type: .floater(), position: .top, autohideIn: 2) {
                Text("Added!")
                    .font(.title3)
                    .foregroundColor(Color(Constants.progressBarColor))
                    .frame(width: 200, height: 60)
                    .background(.white)
                    .cornerRadius(15)
            }
            .onDrop(of: [.url], delegate: HelperDropViewDelegate(model: model))
    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(ViewModel())
    }
}

extension View {
    func readSize(onChange: @escaping (CGSize) -> Void) -> some View {
        background(
            GeometryReader { geometryProxy in
                Color.clear
                    .preference(key: SizePreferenceKey.self, value: geometryProxy.size)
            }
        )
        .onPreferenceChange(SizePreferenceKey.self, perform: onChange)
    }
}

private struct SizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {}
}


