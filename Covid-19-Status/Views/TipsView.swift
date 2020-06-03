//
//  TipsView.swift
//  Covid-19-Status
//
//  Created by Rogerio Lucon on 22/05/20.
//  Copyright © 2020 Rodrigo-Rogerio. All rights reserved.
//

import SwiftUI

struct TipsView: View {
    
    var tip: Tip
    
    var body: some View {
        VStack{
            Text(tip.title).font(.title)
            Text(tip.text)
            
        }
    }
}

struct TipsView_Previews: PreviewProvider {
    static var previews: some View {
        TipsView(tip: tipsData[0])
    }
}
