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
        let lastMonth: [BrazilianState] = DataService.getStateLastMonth(idState)
        let casesList: [CGFloat] = lastMonth.map{
            CGFloat($0.cases)
        }
        let dateList = lastMonth.map{
            String($0.datetime.prefix(10).suffix(5))
        }
        let deathList: [CGFloat] = lastMonth.map{
            CGFloat($0.deaths)
        }
        let suspectsList: [CGFloat] = lastMonth.map{
            CGFloat($0.suspects)
        }
        let refuseList: [CGFloat] = lastMonth.map{
            CGFloat($0.refuses)
        }
        for states: BrazilianState in allStates{
            options.append(states.state)
        }
        
        return ZStack {
            NavigationView {
                ScrollView {
                    Text("").frame(height: 100)
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
                                Recovered(recovereds: brazil.data.recovered, update_at: brazil.data.updated_at).offset(y:-80)
                                
                                                        Cases(cases: brazil.data.cases, suspects: 0, update_at: brazil.data.updated_at).offset(y: -60)
                                
                                Obitos(deaths: brazil.data.deaths, update_at: brazil.data.updated_at).offset(y:-40)
                                
                            }
                            else{
                                Refuse(refuses: state.refuses, update_at: state.datetime ).offset(y:-80)
                                
                                                            Cases(cases: state.cases, suspects:state.suspects, update_at: state.datetime).offset(y: -60)
                                
                                Obitos(deaths: state.deaths, update_at: state.datetime).offset(y:-40)
                                
                                ChartBarView(numberList: casesList, dateList: dateList, title: "Casos Confirmados", xTitle: "Data", yTitle: "Numero de casos").foregroundColor(Color.black)
                                
                                ChartBarView(numberList: suspectsList, dateList: dateList, title: "Casos Suspeitos por data", xTitle: "Data", yTitle: "Numero de casos").foregroundColor(Color.black)
                                
                                ChartBarView(numberList: refuseList, dateList: dateList, title: "Recusados por data", xTitle: "Data", yTitle: "Numero de casos").foregroundColor(Color.black)
                                
                                ChartBarView(numberList: deathList, dateList: dateList, title: "Mortes por data", xTitle: "Data", yTitle: "Numero de Mortes").foregroundColor(Color.black)
                                
                            }
                            
                            //
                        }.offset(y: 50)
                        
                        
                    }
                    Text("").frame(height: 100)
                }
                .navigationBarTitle("")
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









