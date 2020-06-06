//
//  TipsView.swift
//  Covid-19-Status
//
//  Created by Rogerio Lucon on 22/05/20.
//  Copyright © 2020 Rodrigo-Rogerio. All rights reserved.
//

import SwiftUI

struct TipView: View {
    
    var tip: Tip
    
    var body: some View {
        ScrollView{
            VStack{
                HStack {
                    Image("covid")
                        .resizable()
                        .frame(width: 120, height: 120)
                        .clipShape(Circle())
                    Spacer()
                }
                Text(tip.title).font(.title).padding(.vertical, 30)
                Text(tip.text).multilineTextAlignment(.leading)
                Text(tip.source).font(.caption).padding(.vertical, 30)
                Spacer()
            }.padding()
        }
    }
}

struct CellTips: View {
    
    let tip: Tip
    let size: (w: CGFloat, h:CGFloat) = (w: 150, h: 200)
    var cellcColor: Color = Color(red: 0.6196, green: 0.7569, blue: 0.9059, opacity: 1.0)
    let foregroundColor: Color
    var body: some View {
        NavigationLink(destination: TipView(tip: tip)){
            ZStack(alignment: .bottom){
                Text("").frame(width: size.w, height: size.h)
                    .background(cellcColor)
                    .cornerRadius(25)
                    
                Text(tip.title).frame(width: 120)
                    .font(.headline)
                    .foregroundColor(foregroundColor)
                    .offset(y: -16)
                
                Circle().frame(width: 80, height: 80)
                    .offset(y: -size.h / 2).foregroundColor(Color(red: 0.4314, green: 0.5804, blue: 0.8510, opacity: 1.0))
            }.shadow(color: Color.black.opacity(0.3), radius: 10)
        }
    }
}

struct TipsView_Previews: PreviewProvider {
    static var previews: some View {
        CellTips(tip: tipsData[1], foregroundColor: Color.black)
    }
}
