//
//  EntryView.swift
//  Qeii
//
//  Created by 陈卓学 on 18/07/2022.
//

import SwiftUI

struct EntryView: View {
    var body: some View {
        ZStack(alignment: .top) {
            Rectangle()
                .frame(height: 500.0)
                .ignoresSafeArea()
                .foregroundColor(Color(Constants.backgroundColor))
            
            VStack {
                ZStack(alignment: .leading) {
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(height: 30)
                    HStack {
                        ZStack {
                            Circle()
                                .frame(width: 25, height: 25)
                                .foregroundColor(.white)
                            Image(systemName: "creditcard.fill")
                                .foregroundColor(Color(Constants.backgroundColor))
                                .font(.system(size: 12))
                        }
                        .padding(.leading, 20)
                        Text("Entry")
                            .font(.system(size: 27))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        
                    }
                }
                ZStack(alignment: .top) {
                    Rectangle()
                        .foregroundColor(.white)
                        .cornerRadius(27)
                    ScrollView {
                        EntryItem()
                        
                    }
                }
            }
        }
    }
}

struct EntryView_Previews: PreviewProvider {
    static var previews: some View {
        EntryView()
    }
}

struct EntryItem: View {
    var body: some View {
        HStack {
            // icon
            ZStack {
                Rectangle()
                    .frame(width: 60, height: 60)
                    .foregroundColor(Color(Constants.iconBGC))
                    .cornerRadius(15)
                Text("☕️")
                    .font(.system(size: 35))
            }
            .padding([.top, .leading, .bottom])
            
            GeometryReader() { geometry in
                
                ZStack {
                    HStack {
                        
                        // category and date
                        VStack(alignment: .leading) {
                            Text("Coffee")
                                .font(.title3)
                                .fontWeight(.medium)
                                .padding(.bottom, 1.0)
                            Text("2022.7.12 14:23")
                                .foregroundColor(.gray)
                            
                        }
                        
                        Spacer()
                        
                        //amount and indicator
                        Text("£89.12")
                            .font(.title3)
                            .fontWeight(.medium)
                        
                        Image(systemName: "chevron.right")
                    }
                    
                    VStack {
                        Rectangle()
                            .foregroundColor(.clear)
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(Color(Constants.progressBarColorGray))
                    }
                }
                .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
                
                
                
            }
            .padding(.trailing)
            .padding(.leading, 5.0)
            
        }
    }
}
