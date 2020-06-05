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
//    let size: (w: CGFloat, h:CGFloat) = (w: 320, h: 120)
    let brazil = DataService.getCountry("brazil")!
    
    var body: some View {
        RecoveredHome(recovereds: brazil.data.recovered, update_at: brazil.data.updated_at)
        
    }
//        ZStack (alignment: .leading) {
//            HStack {
//                VStack (alignment: .leading){
//                    VStack {
//                        VStack(alignment: .leading) {
//                            Text("\(brazil.data.recovered)").font(.title)
//                            Text("Casos recuperados").font(.subheadline)
//                        }
//                        .padding(.top)
//                        VStack(alignment: .leading) {
//                            Text("\(brazil.data.cases)").font(.title)
//                            Text("Em acompanhamento").font(.subheadline)
//                        }
//                        .padding(.top)
//                        Text("data: \(brazil.data.updated_at)").font(.caption)
//                            .padding(.top)
//                    }
//                }
//                Spacer()
//                Text("").frame(width: 100, height: 100).background(Color.green)
//            }
//        }.padding()//.padding([.horizontal, .top])
//            .frame(width: size.w)
//            .background(bgColor)
//            .cornerRadius(25)
//    }
        
//    init() {
//
//    }
}

struct HomeDataOverView_Previews: PreviewProvider {
    static var previews: some View {
        HomeDataOverView()
        //        CellData()
    }
}
