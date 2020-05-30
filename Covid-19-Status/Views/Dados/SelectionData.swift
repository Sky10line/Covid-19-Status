//
//  SwiftUIView.swift
//  Covid-19-Status
//
//  Created by Rodrigo Ryo Aoki on 29/05/20.
//  Copyright © 2020 Rodrigo-Rogerio. All rights reserved.
//

import SwiftUI

struct SelectionData: View {
    var body: some View {
//        var options = DataService.getAllStates()
        NavigationView{

               NavigationLink(destination: ContentView(url: "https://covid19-brazil-api.now.sh/api/report/v1/brazil/uf/sp")) {
                        Text("soh bora")
                    }.navigationBarHidden(true)



        }
        .navigationBarHidden(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SelectionData()
    }
}
