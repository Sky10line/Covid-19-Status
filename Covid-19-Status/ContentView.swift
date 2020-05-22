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
        
        Text(catchdata())
    }
}

func catchdata() -> String{
    var sp: String = "nada"
    if let url = URL(string: "https://covid19-brazil-api.now.sh/api/report/v1/brazil/uf/sp"){
        print("1")
        URLSession.shared.dataTask(with: url){
            data, response, error in
            print("2")
            if let data = data{
                print("3")
                do{
                    let res = try JSONDecoder().decode(Response.self, from: data)
                    print("4")
                } catch let erro{
                    print(erro)
                }
            }
        }.resume()
    }

    print("5")
    return sp
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
