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
            Text("Casos recuperados").font(.title).fontWeight(.bold).foregroundColor(Color.white).multilineTextAlignment(.leading)
        
            Text(String(refuses)).font(.title).fontWeight(.bold).foregroundColor(Color.white).multilineTextAlignment(.center)
        
        }).frame(width: 287).padding(EdgeInsets(top: 20, leading: 13, bottom: 60, trailing: 47))
            .background(Color(red: 0.3412, green: 0.4353, blue: 0.7647, opacity: 1.0))
            .cornerRadius(10.0).shadow(radius: 10.0)
    
    }
}

struct Refuses_Previews: PreviewProvider {
    static var previews: some View {
        Refuses(refuses: 2)
    }
}
