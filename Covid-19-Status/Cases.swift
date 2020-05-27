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
    var body: some View {
        VStack(alignment: .leading, spacing: 18, content: {
            Text("Casos").font(.headline).fontWeight(.heavy).foregroundColor(Color(red: 0.3059, green: 0.6353, blue: 0.5255, opacity: 1.0)).multilineTextAlignment(.leading)
            HStack{
                Text(String(cases) + "\nConfirmados").font(.headline).fontWeight(.bold).foregroundColor(Color.black).multilineTextAlignment(.center)
                
                Spacer()
                
                Text(String(suspects) + "\nSuspeitos").font(.headline).fontWeight(.bold).foregroundColor(Color.black).multilineTextAlignment(.center)
                
            }
            .frame(width: 300.0)
        }).padding(EdgeInsets(top: 40, leading: 20, bottom: 60, trailing: 20)).overlay(
        RoundedRectangle(cornerRadius: 10)
            .stroke(Color(red: 0.3059, green: 0.6353, blue: 0.5255, opacity: 1.0), lineWidth: 5))
            .background(Color.white)
            .cornerRadius(10.0).shadow(radius: 10.0)
    }
}


struct Cases_Previews: PreviewProvider {
    static var previews: some View {
        Cases(cases: 10, suspects: 100)
    }
}
