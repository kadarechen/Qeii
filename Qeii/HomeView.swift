//
//  HomeView.swift
//  Qeii
//
//  Created by 陈卓学 on 2022/6/26.
//

import SwiftUI
import PopupView

struct HomeView: View {
    
    @State var showAddRecordView = false
    
    let columns = [GridItem(.flexible(), spacing: 15), GridItem(.flexible(), spacing: 15), GridItem(.flexible(), spacing: 15)]
    let categories = [0,1,2,3,4]
    
    var body: some View {
        GeometryReader { _ in
            ZStack {
                Rectangle()
                    .ignoresSafeArea()
                    .foregroundColor(Color(Constants.backgroundColor))
                VStack {
                    HStack(alignment: .bottom) {
                        Text("Expenditure")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        Spacer()
                        Text("136.38")
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
                        LazyVGrid(columns: columns, spacing: 15) {
                            ForEach(categories, id: \.self) {_ in
                                Button{
                                    showAddRecordView = true
                                } label: {
                                    ZStack {
                                        Rectangle()
                                            .frame(height: 120)
                                            .foregroundColor(Color(Constants.categoryGridBGColor))
                                            .cornerRadius(16)
                                        VStack {
                                            Text("🥘")
                                                .font(.system(size: 58))
                                            Text("Lunch")
                                                .foregroundColor(Color(Constants.categoryTitleColor))
                                        }
                                    }
                                }
                            }
                        }
                        .padding()
                    }
                    .padding(.top)
                    
                    
                    Spacer()
                }
                .ignoresSafeArea(.all, edges: .bottom)
            }
            .popover(isPresented: $showAddRecordView) {
                AddRecordView(showAddRecordView: $showAddRecordView)
            }
        
        }.ignoresSafeArea(.keyboard, edges: .bottom)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
