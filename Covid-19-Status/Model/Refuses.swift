//
//  Refuses.swift
//  Covid-19-Status
//
//  Created by Rodrigo Ryo Aoki on 26/05/20.
//  Copyright © 2020 Rodrigo-Rogerio. All rights reserved.
//

import SwiftUI

struct Refuse: View {
    var refuses: Int
    var update_at: String
    
    var body: some View {
        let update_atDate = update_at.components(separatedBy: "T")
        return VStack(alignment: .leading, spacing: 18, content: {
            Text("Casos rejeitados").font(.title).fontWeight(.bold).foregroundColor(Color.white).multilineTextAlignment(.leading)
        
            Text(String(refuses)).font(.title).fontWeight(.bold).foregroundColor(Color.white).multilineTextAlignment(.center)
            
            Text("Atualizado em: " + update_atDate[0])
            .font(.footnote)
            .foregroundColor(Color.white)
        
        }).frame(width: 287).padding(EdgeInsets(top: 20, leading: -5, bottom: 20, trailing: 65))
            .background(Color(red: 0.3412, green: 0.4353, blue: 0.7647, opacity: 1.0))
            .cornerRadius(10.0).shadow(radius: 10.0)
    
    }
}

struct Refuse_Previews: PreviewProvider {
    static var previews: some View {
        Refuse(refuses: 2, update_at: "dia 2")
    }
}
