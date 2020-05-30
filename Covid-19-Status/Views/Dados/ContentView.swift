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
    var url: String
    var body: some View {
        let res = catchdata(endereco: url)
        return NavigationView {
             VStack {
                Refuses(refuses: res!.refuses).offset(y:-80)
                
                Cases(cases: res!.cases, suspects: res!.suspects).offset(y: -60)
                
                Obitos(deaths: res!.deaths).offset(y:-40)
                
                NavigationLink(destination: SelectionData()) {
                    Text("funciona porra!")
                }
            }

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



