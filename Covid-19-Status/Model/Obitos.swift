//
//  Obitos.swift
//  Covid-19-Status
//
//  Created by Rodrigo Ryo Aoki on 27/05/20.
//  Copyright © 2020 Rodrigo-Rogerio. All rights reserved.
//

import SwiftUI

struct Obitos: View {
    var deaths: Int
    var body: some View {
        VStack(alignment: .leading, spacing: 18, content: {
            Text("Óbitos").font(.title).fontWeight(.bold).foregroundColor(Color.white).multilineTextAlignment(.leading)
        
            Text(String(deaths)).font(.title).fontWeight(.bold).foregroundColor(Color.white).multilineTextAlignment(.center)
        
        }).padding(EdgeInsets(top: 20, leading: 30, bottom: 60, trailing: 230))
            .background(Color(red: 0.6000, green: 0.6745, blue: 0.8549, opacity: 1.0))
            .cornerRadius(10.0).shadow(radius: 10.0)
    }
}

struct Obitos_Previews: PreviewProvider {
    static var previews: some View {
        Obitos(deaths: 0)
    }
}
