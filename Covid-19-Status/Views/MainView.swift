//
//  MainView.swift
//  Covid-19-Status
//
//  Created by Rogerio Lucon on 22/05/20.
//  Copyright © 2020 Rodrigo-Rogerio. All rights reserved.
//

import SwiftUI

struct MainView: View {
    
    @State private var selection = 0
    
    var body: some View {
        TabView(selection: $selection) {
            HomeView().tabItem {
                Text("Home")
            }.tag(0)
            
            ContentView().tabItem {
                Text("Content")
            }.tag(1)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
