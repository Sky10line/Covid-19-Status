//
//  List.swift
//  Covid-19-Status
//
//  Created by Rodrigo Ryo Aoki on 01/06/20.
//  Copyright © 2020 Rodrigo-Rogerio. All rights reserved.
//

import SwiftUI

struct List: View {
    
    @ObservedObject var controler: ChangeValues
    
    var body: some View {
        //        List(DataService.getAllContries, id: \.id) { BrazilianState in
        //        SelectionData(state: BrazilianState)
        //        }.navigationBarTitle(Text("Testando"))
        VStack {
            Text("\(controler.value)")
            Button(action: {
                self.controler.value += 10
            }){
                Text("\(controler.value)")
            }
        }
    }
    
    init(controller: ChangeValues) {
        self.controler = controller
    }
}

struct List_Previews: PreviewProvider {
    static var previews: some View {
        List(controller: ChangeValues())
    }
}
