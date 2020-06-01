//
//  SwiftUIView.swift
//  Covid-19-Status
//
//  Created by Rogerio Lucon on 01/06/20.
//  Copyright © 2020 Rodrigo-Rogerio. All rights reserved.
//

import SwiftUI

class ChartViewModel: ObservableObject {
    @Published var selected: Int = 0
    let list: [[CGFloat]] = [[10,20,30],[30,40,50],[0,100,50]]
    
    func getList() -> [CGFloat] {
        return list[selected]
    }
}

struct ChartBarView: View {
    
    @ObservedObject var viewModel = ChartViewModel()
    let title: String = "Nome do grafico"
    let xTitle: String = "Parametro x"
    let yTitle: String = "Parametro y"
    //     @State var selected: Int = 0
    
    var body: some View {
        
        
        ZStack {
            Color(.gray).edgesIgnoringSafeArea(.all)
            
            VStack {
                Text(title).font(.title)
                
                Picker(selection: $viewModel.selected, label: Text("")) {
                    Text("Mes").tag(0)
                    Text("Semana").tag(1)
                    Text("Dia").tag(2)
                }.pickerStyle(SegmentedPickerStyle())
                    .padding(.horizontal)
                
                HStack {
                    
                    BarsChart(value: viewModel.getList()[0])
                    
                    
                    BarsChart(value: viewModel.getList()[1])
                    BarsChart(value: viewModel.getList()[2])
                }.padding()
                    .animation(.default)
            }
        }
        
    }
}


struct BarsChart: View {
    var value: CGFloat
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Capsule().frame(width: 30, height: 100)
            Capsule().frame(width: 30, height: value)
                .foregroundColor(Color.white)
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        ChartBarView()
    }
}


