//
//  TipsMainView.swift
//  Covid-19-Status
//
//  Created by Rogerio Lucon on 30/05/20.
//  Copyright © 2020 Rodrigo-Rogerio. All rights reserved.
//

import SwiftUI

struct TipsMainView: View {
    
    @Environment(\.localStatusBarStyle) var statusBarStyle
    var tips = tipsData
    let bgColor = Color.secondary
    let cellColor = Color.primary
    
    var body: some View {
        statusBarStyle.currentStyle = .darkContent
        return NavigationView{
            VStack{
                HStack {
                    TipsMainViewHeader()
                }.zIndex(1)
                    .background(bgColor)
                ScrollView {
                    VStack {
                        ForEach(0..<tips.count) { index in
                            if index % 2 == 0 {
                                HomeTipsRow(tips: self.tips, index: index, cellColor: self.cellColor, cellForegroundColor: Color.white)
                            }
                        }
                    }
                }.zIndex(0)
            }.background(bgColor)
            .edgesIgnoringSafeArea(.top)
        }
        .navigationBarTitle("Dicas")
        .navigationBarHidden(true)
        
    }
}

struct TipsMainViewHeader: View {
    
    var tips = tipsData
    let bgColor = Color.secondary
    
    var body: some View {
//        ZStack{
            VStack {
                Rectangle()
                    .fill(bgColor)
                .frame(height: 24)
                HStack {
                    Text("Dicas").font(.title).bold()
                    Spacer()
                    Rectangle().frame(height: 32)
                    
                }.padding()
            }
//        }
        
    }
}

struct TipsMainView_Previews: PreviewProvider {
    static var previews: some View {
        TipsMainView()
    }
}
