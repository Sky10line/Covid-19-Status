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
    @State var idState = ""
    @State private var selectedStateIndex = 0
    @State private var backOpacity = 1.0
    var body: some View {
        
        let state = DataService.getState(idState)!
        let brazil = DataService.getCountry("brazil")!
        let allStates = DataService.getAllStates().data
        var options = [String]()
        options.append("Brasil")
        for states: BrazilianState in allStates{
            options.append(states.state)
        }
        
        return ZStack {
            NavigationView {
                VStack(alignment: .leading) {
                    Button(action: {
                        self.backOpacity = 0.3
                        withAnimation{
                            self.isPresented.toggle()
                        }
                    }, label: {
                        if selectedStateIndex == 0{
                            Text("Brasil").font(.title)
                        }
                        else{
                        Text(allStates[selectedStateIndex-1].state)
                            .font(.title)
                        }
                        Image(systemName: "chevron.right").offset(y: 2)
                    }).offset(x: 10, y: -100)
                    VStack {
                        if(selectedStateIndex == 0){
                        Recovered(recovereds: brazil.data.recovered).offset(y:-80)
                            
                        Cases(cases: brazil.data.cases, suspects: 0).offset(y: -60)
                        //
                        Obitos(deaths: brazil.data.deaths).offset(y:-40)
                        }
                        else{
                            Recovered(recovereds: state.refuses).offset(y:-80)
                                
                            Cases(cases: state.cases, suspects:state.suspects).offset(y: -60)
                            //
                            Obitos(deaths: state.deaths).offset(y:-40)
                            
                        }
                        
                    }.offset(y:-20)
                   
                    
                }.navigationBarTitle("")
                .navigationBarHidden(true).opacity(backOpacity)
            }
            ZStack{
                HStack{
                    Spacer()
                    VStack(alignment: .center, spacing: 10, content: {
                        VStack(alignment: .center, spacing: 10, content: {
                            Text("Selecione um estado:").font(.body).foregroundColor(Color.black).offset(x: 5, y: 30)
                            Picker(selection: $selectedStateIndex, label: Text("")) {
                                ForEach(0 ..< options.count) {
                                    Text(options[$0])
                                }
                            }
                        }).background(Color.white)
                        .cornerRadius(10.0)
                        Button(action: {
                            self.backOpacity = 1.0
                            if(self.selectedStateIndex > 0){
                                self.idState = allStates[self.selectedStateIndex-1].uf
                                print("trocou o nome")
                            }
                            print(String(self.selectedStateIndex))
                            withAnimation{
                                self.isPresented.toggle()
                            }
                            print(String(self.isPresented))
                        }, label: {
                            Text("Confimar").frame(width: 300.0, height: 10.0).padding()
                                .background(Color.white).cornerRadius(10.0).foregroundColor(Color.blue).offset(x: 5)
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









