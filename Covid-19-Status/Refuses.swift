//
//  Refuses.swift
//  Covid-19-Status
//
//  Created by Rodrigo Ryo Aoki on 26/05/20.
//  Copyright © 2020 Rodrigo-Rogerio. All rights reserved.
//

import SwiftUI

struct Refuses: View {
    var refuses: Int
    var body: some View {
        VStack(alignment: .leading, spacing: 18, content: {
        Text("Casos recusados").font(.headline).foregroundColor(Color.white).multilineTextAlignment(.leading)
        
        Text(String(refuses)).font(.largeTitle).fontWeight(.bold).foregroundColor(Color.white).multilineTextAlignment(.leading)
        
        }).padding(EdgeInsets(top: 40, leading: 20, bottom: 60, trailing: 180)).overlay(
        RoundedRectangle(cornerRadius: 10)
            .stroke(Color.white, lineWidth: 5))
        .background(Color(red: 0.3059, green: 0.6353, blue: 0.5255, opacity: 1.0))
            .cornerRadius(10.0).shadow(radius: 10.0)
    
    }
}

struct Refuses_Previews: PreviewProvider {
    static var previews: some View {
        Refuses(refuses: 2)
    }
}
