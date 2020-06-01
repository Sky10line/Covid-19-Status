//
//  SwiftUIView.swift
//  Covid-19-Status
//
//  Created by Rodrigo Ryo Aoki on 29/05/20.
//  Copyright © 2020 Rodrigo-Rogerio. All rights reserved.
//

import SwiftUI

struct SelectionData: View {
    var state: BrazilianState
    var body: some View {
        Text(state.state)
        
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SelectionData(state: DataService.getAllStates().data[1])
    }
}
