//
//  List.swift
//  Covid-19-Status
//
//  Created by Rodrigo Ryo Aoki on 01/06/20.
//  Copyright © 2020 Rodrigo-Rogerio. All rights reserved.
//

import SwiftUI

struct List: View {
    var body: some View {
        List(DataService.getAllContries, id: \.id) { BrazilianState in
        SelectionData(state: BrazilianState)
        }.navigationBarTitle(Text("Testando"))
    }
}

struct List_Previews: PreviewProvider {
    static var previews: some View {
        List()
    }
}
