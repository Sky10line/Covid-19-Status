//
//  HomeDataOverView.swift
//  Covid-19-Status
//
//  Created by Rogerio Lucon on 25/05/20.
//  Copyright © 2020 Rodrigo-Rogerio. All rights reserved.
//

import SwiftUI

struct HomeDataOverView: View {
    
    var body: some View {
        VStack {
            CellDataRec()
            Spacer()
        }
    }
}

struct  CellDataRec: View {
    
    var bgColor: Color = Color.secondary
    let size: (w: CGFloat, h:CGFloat) = (w: 320, h: 120)
    
    var body: some View {
        ZStack (alignment: .leading) {
            HStack {
                VStack (alignment: .leading){
                    VStack {
                        VStack(alignment: .leading) {
                            Text("100.000").font(.title)
                            Text("Casos recuperados").font(.subheadline)
                        }
                        .padding(.top)
                        VStack(alignment: .leading) {
                            Text("100.00").font(.title)
                            Text("Em acompanhamento").font(.subheadline)
                        }
                        .padding(.top)
                    }
                }
                Spacer()
                Text("").frame(width: 100, height: 100).background(Color.green)
            }
        }.padding()//.padding([.horizontal, .top])
            .frame(width: size.w)
            .background(bgColor)
            .cornerRadius(25)
    }
}

struct HomeDataOverView_Previews: PreviewProvider {
    static var previews: some View {
        HomeDataOverView()
        //        CellData()
    }
}
