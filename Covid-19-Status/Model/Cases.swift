//
//  Cases.swift
//  Covid-19-Status
//
//  Created by Rodrigo Ryo Aoki on 27/05/20.
//  Copyright © 2020 Rodrigo-Rogerio. All rights reserved.
//

import SwiftUI

struct Cases: View {
    var cases: Int
    var suspects: Int
    var update_at: String
    var body: some View {
        let update_atDate = update_at.components(separatedBy: "T")
        return VStack(alignment: .leading, spacing: 18, content: {
            Text("Casos acumulados").font(.title).fontWeight(.heavy).foregroundColor(Color.white).multilineTextAlignment(.leading)
            
            
            HStack{
                Spacer()
                Text(String(cases) + "\nConfirmados").font(.headline).fontWeight(.bold).foregroundColor(Color.white).multilineTextAlignment(.center)
                
                Spacer()
                if (suspects > 0){
                Text(String(suspects) + "\nSuspeitos").font(.headline).fontWeight(.bold).foregroundColor(Color.white).multilineTextAlignment(.center)
                Spacer()
                }
                
            }.frame(width: 287.0)
            
            Text("Atualizado em: " + update_atDate[0])
            .font(.footnote)
            .foregroundColor(Color.white)
        }).padding(EdgeInsets(top: 20, leading: 30, bottom: 20, trailing: 30))
            .background(Color(red: 0.4314, green: 0.5804, blue: 0.8510, opacity: 1.0))
            .cornerRadius(10.0).shadow(radius: 10.0)
    }
}


struct Cases_Previews: PreviewProvider {
    static var previews: some View {
        Cases(cases: 10, suspects: 100, update_at: "dia 2")
    }
}
