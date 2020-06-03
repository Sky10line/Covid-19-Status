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

struct ContentView: View {
    @State var isPresented = false
    @State var idState: String
    @State private var selectedStateIndex = 0
    @State private var backOpacity = 1.0
    var body: some View {
        
        let state = DataService.getState(idState)!
        let allStates = DataService.getAllStates().data
        
        
        return ZStack {
            NavigationView {
                VStack {
                    VStack {
                        Recovered(recovereds: state.refuses).offset(y:-80)
                        
                        Cases(cases: state.cases, suspects: state.suspects).offset(y: -60)
                        //
                        Obitos(deaths: state.deaths).offset(y:-40)
                    }.offset(y:-50)
                   Button(action: {
                        self.backOpacity = 0.3
                        withAnimation{
                            self.isPresented.toggle()
                        }
                    }, label: {
                        Text(allStates[selectedStateIndex].state)
                            .font(.title)
                        Image(systemName: "chevron.right").offset(y: 2)
                    }).offset(x:-110)
                    
                }.opacity(backOpacity).navigationBarHidden(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
            }
            ZStack{
                HStack{
                    Spacer()
                    VStack(alignment: .center, spacing: 10, content: {
                        VStack(alignment: .center, spacing: 10, content: {
                            Text("Selecione um estado:").font(.body).offset(x: 5, y: 30)
                            Picker(selection: $selectedStateIndex, label: Text("")) {
                                ForEach(0 ..< allStates.count) {
                                    Text(allStates[$0].state)
                                }
                            }
                        }).background(Color.white)
                        .cornerRadius(10.0)
                        Button(action: {
                            self.backOpacity = 1.0
                            self.idState = allStates[self.selectedStateIndex].uf
                            withAnimation{
                                self.isPresented.toggle()
                            }
                            print(String(self.isPresented))
                        }, label: {
                            Text("Confimar").frame(width: 300.0, height: 10.0).padding()
                                .background(Color.white).cornerRadius(10.0).foregroundColor(Color.black).offset(x: 5)
                        }).background(Color.white)
                        .cornerRadius(10.0)
                    
                    }).frame(width: 287).padding(EdgeInsets(top: 0, leading: 26, bottom: 60, trailing: 34))
                        .shadow(radius: 50.0)
                        
                        
                   Spacer()
                }
            }.offset(x:0, y: isPresented ? 0: UIApplication.shared.keyWindow?.frame.height ?? 0)
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(idState: "sp")
    }
}









