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
}

struct ContentView: View {
    @ObservedObject var vm: ChangeValues = ChangeValues()
    var url: String
    var body: some View {
        let res = catchdata(endereco: url)
        return ZStack{
            NavigationView {
                 VStack {
                    VStack{
                    Refuses(refuses: res!.refuses).offset(y:-80)
                    
                    Cases(cases: res!.cases, suspects: res!.suspects).offset(y: -60)
                    
                    Obitos(deaths: res!.deaths).offset(y:-40)
                    }.offset(y:-50)
                    Button(action: {
                        withAnimation{
                            self.vm.isPresented.toggle()
                        }
                        print(String(self.vm.isPresented))
                        }, label: {
                            Text("btnTeste")
                        })
                    
                    }
            }
            
            ZStack{
                VStack{
                    
                    
                    Button(action: {
                    withAnimation{
                        self.vm.isPresented.toggle()
                    }
                    print(String(self.vm.isPresented))
                    }, label: {
                        Text("Voltar")
                            .foregroundColor(Color.purple)
                    }).offset(x:-160, y:-790)
                    
                }
            }.offset(x:0, y: vm.isPresented ? 0: UIApplication.shared.keyWindow?.frame.height ?? 0)
            
        }
        .navigationBarHidden(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
    }
}

func catchdata(endereco: String) -> Response? {
    var res: Response!
    let group = DispatchGroup()
    group.enter()
    if let url = URL(string: endereco){
        print("1")

        URLSession.shared.dataTask(with: url){
            data, response, error in
            print("2")
            if let data = data{
                print("3")
                do{
                   let teste = try JSONDecoder().decode(Response.self, from: data)
                    print(teste.state)
                    res = teste
                    
//                    let teste = String(data: data, encoding: .utf8)
                    
                    print(teste)
                } catch let erro{
                    print(erro)
                }
            }
            group.leave()
        }.resume()
    }
    group.wait()
    print("5")
    return res
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(url: "https://covid19-brazil-api.now.sh/api/report/v1/brazil/uf/sp")
    }
}



