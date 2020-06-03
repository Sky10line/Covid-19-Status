//
//  MainView.swift
//  Covid-19-Status
//
//  Created by Rogerio Lucon on 22/05/20.
//  Copyright © 2020 Rodrigo-Rogerio. All rights reserved.
//

import SwiftUI

struct MainView: View {
    
//    @State private var selection = 0
    @EnvironmentObject var appData: AppData
    
    var color = Color.primary
    var body: some View {
        TabView(selection: $appData.tabSelec) {
            HomeView(appData: appData)
                .tabItem {
                Text("Home")
            }.tag(0)
            TipsMainView().tabItem {
                Text("Dicas")
            }.tag(1)
            
            Button(action: {
                
            }){
                ContentView(idState: "sp")
                }.tabItem{
                    Text("Dados")
                }.tag(2)
        }.background(color)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView().environmentObject(AppData())
    }
}
