//
//  AddRecordView.swift
//  Qeii
//
//  Created by 陈卓学 on 2022/6/26.
//

import SwiftUI

struct AddRecordView: View {
    
    @State var note: String = ""
    @Binding var showAddRecordView: Bool
    
    var body: some View {
        GeometryReader {_ in
            VStack {
                HStack {
                    VStack {
                        Text("🥘")
                            .font(.system(size: 58))
                        Text("Lunch")
                            .foregroundColor(Color(Constants.categoryTitleColor))
                    }
                    Spacer()
                    Text("289")
                        .font(.system(size: 80))
                        .fontWeight(.semibold)
                        .foregroundColor(Color(Constants.categoryTitleColor))
                }
                .padding()
    //            RoundedRectangle(cornerRadius: 10)
    //                .frame(height: 100.0)
    //                .foregroundColor(.white)
    //                .border(Color(Constants.progressBarColorGray), width: 5)
    //                .padding(.horizontal)
    //                .stroke(Color.orange, lineWidth: 4)
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                                    .frame(height: 50)
                                    .foregroundColor(.white)
                                    .overlay(
                                                RoundedRectangle(cornerRadius: 10)
                                                    .stroke(Color(Constants.progressBarColorGray), lineWidth: 2)
                                            )
                    TextField("Note (Optionol)", text: $note)
                        .padding(.horizontal)
                }
                .padding(.horizontal)
                
                HStack {
                    Button {
                        showAddRecordView = false
                        //TO-DO: add record
                    } label: {
                        ZStack {
                            Rectangle()
                                .frame(height: 50.0)
                                .cornerRadius(10)
                                .foregroundColor(Color(Constants.progressBarColor))
                            Text("Add")
                                .font(.title3)
                                .foregroundColor(.white)
                        }
                    }
                    
                    Button {
                        showAddRecordView = false
                    } label: {
                        ZStack {
                            Rectangle()
                                .cornerRadius(10)
                                .frame(width: 50.0, height: 50.0)
                                .foregroundColor(Color(Constants.progressBarColorGray))
                            Image(systemName: "xmark")
                                .font(.title3)
                                .foregroundColor(.white)
                        }
                        
                        
                    }
                }
                .padding()
                
                Spacer()
                    
                Keyboard()
            }
            
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}

//struct AddRecordView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddRecordView()
//    }
//}
