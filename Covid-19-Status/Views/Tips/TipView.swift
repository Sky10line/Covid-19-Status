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

struct TipsView_Previews: PreviewProvider {
    static var previews: some View {
        TipView(tip: tipsData[5])
    }
}
