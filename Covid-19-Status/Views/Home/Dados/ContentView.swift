//
//  ContentView.swift
//  Covid-19-Status
//
//  Created by Rodrigo Ryo Aoki on 21/05/20.
//  Copyright © 2020 Rodrigo-Rogerio. All rights reserved.
//

//https://www.youtube.com/watch?v=IIDiqgdn2yo
//video tutorial de SwiftUI

import SwiftUI

class ChangeValues: ObservableObject {
    @Published var isPresented = false
    @Published var score2 = 7
    @Published var value = 10
}

struct ContentView: View {
    @ObservedObject var vm: ChangeValues = ChangeValues()
    
    var idState: String
    
    var body: some View {
        let states = DataService.getState(idState)
        print(DataService.getAllStates().data)
        return ZStack {
            NavigationView {
                VStack {
                    Text("Consertando")
                }.navigationBarHidden(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
            }
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(idState: "sp")
    }
}









