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
    var body: some View {
        let sp = catchdata()
        return VStack {
            Text("Estado: " + sp!.state)
            Text("Casos: " + String(sp!.cases))
            Text("Mortes: " + String(sp!.deaths))
            Text("Suspeitas: " + String(sp!.suspects))
            Text("Recuperadas: " + String(sp!.refuses))
            
        }
       
    }
}

func catchdata() -> Response? {
    var res: Response!
    let group = DispatchGroup()
    group.enter()
    if let url = URL(string: "https://covid19-brazil-api.now.sh/api/report/v1/brazil/uf/sp" ){
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
        ContentView()
    }
}
