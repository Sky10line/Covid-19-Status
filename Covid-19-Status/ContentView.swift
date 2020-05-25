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
        let sp = catchdata(endereco: "https://covid19-brazil-api.now.sh/api/report/v1/brazil/uf/sp")
        return VStack {
            
            DropDownMenu().offset(x: -150, y: -350)
            
//            Text("Estado: " + sp!.state)
//            Text("Casos: " + String(sp!.cases))
//
//            Text("Mortes: " + String(sp!.deaths))
//            Text("Suspeitas: " + String(sp!.suspects))
//            Text("Recuperadas: " + String(sp!.refuses))
        }
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


struct DropDownMenu: View {
    
    @State var expand = false
    @State var name = "Expand"
    var body: some View {
        
        VStack(alignment: .leading, spacing: 18, content: {
            
            HStack{
                Text(name).fontWeight(.heavy).foregroundColor(.black).padding(.leading).frame(width: nil)
                Image(systemName: expand ? "chevron.up": "chevron.down").resizable().frame(width: 13, height: 6).foregroundColor(.black)
            }.onTapGesture {
                self.expand.toggle()
            }
            
            if expand{
                Button(action: {self.expand = false; self.name = "Select 1"}) {
                    
                    Text("Select 1").padding()
                    
                    
                }.foregroundColor(.black)
                
                Button(action: {self.expand = false}) {
                    
                    Text("Select 2").padding()
                    
                }.foregroundColor(.black)
                
                Button(action: {self.expand = false}) {
                    
                    Text("Select 3").padding()
                    
                }.foregroundColor(.black)
            }
        })
        .padding(7)
        .background(expand ? Color.gray : Color.white)
        .cornerRadius(20)
        .animation(.spring())
    }
}
