//
//  HomeView.swift
//  Covid-19-Status
//
//  Created by Rogerio Lucon on 22/05/20.
//  Copyright © 2020 Rodrigo-Rogerio. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    
    @Environment(\.localStatusBarStyle) var statusBarStyle
    var appData: AppData
    
    @State var safeHide = false
    @State var offset: CGFloat = 0
    
    var bgColor = Color.primary
    
    var body: some View {
        NavigationView {
//            VStack {
                ScrollView {
                    VStack {
                        HomeHeader().frame(height: 270).zIndex(1)
                        GeometryReader { innerGeo -> Text in
                            self.offset = innerGeo.frame(in: .global).minY + 60
                            if self.offset < 120 {
                                self.statusBarStyle.currentStyle = .darkContent
                            } else{
                                self.statusBarStyle.currentStyle = .lightContent
                            }
                            return Text("")
                        }.background(Color.clear)
                        HomeBody(listSize: 4, appData: appData)
                            .offset(y: -200).zIndex(2)
                    }
                }.background(Color.white)
//                Text("\(self.offset)").frame(height: 36)
//            }
        .navigationBarTitle("Home")
            .navigationBarHidden(true)
            .edgesIgnoringSafeArea(.top)
        }
    }
}

struct HomeHeader: View {
    
    var body: some View {
        Image("covid2").resizable()
        
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(appData: AppData())
    }
}

