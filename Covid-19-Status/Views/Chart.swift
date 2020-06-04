//
//  SwiftUIView.swift
//  Covid-19-Status
//
//  Created by Rogerio Lucon on 01/06/20.
//  Copyright © 2020 Rodrigo-Rogerio. All rights reserved.
//

import SwiftUI

class ChartViewModel: ObservableObject {
    @Published var selected: Int = 0 {didSet {
        list = allListst[selected]
        }}
    @Published var list: [CGFloat] = [50,100,150,200,50,100,150,200,50,100,150,200,50,100,150,200,200,50,100,150,200,50,100,150,200,200,50,100,150,200,50,100,150,200]
    let allListst: [[CGFloat]] = [[10,20,100,200],[40,30,20,10],[10,20,30,20,10]]
    
}

struct ChartBarView: View {
    
    @ObservedObject var viewModel = ChartViewModel()
    @State var title: String = "Nome do grafico"
    @State var xTitle: String = "Parametro x"
    @State var yTitle: String = "Parametro y"
    
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
                VStack(alignment: .leading) {
                    
                    VStack {
                        HStack(alignment: .center) {
                            ZStack {
                            Text(yTitle)
                                .frame(width: 150)
                                .lineLimit(1)
                                .rotationEffect(Angle(degrees: 90))
                            }.frame(width: 0)
                            Spacer()
//                            ScrollView(.horizontal) {
                            HStack(alignment: .bottom, spacing: 6) {
                                ForEach(viewModel.list, id: \.self) { i in
                                    BarsChart(value: i, width: self.getBarWidth(), parentHeigth: 300, maxValue: 200)
                                }
                            }
                            .frame(height: 300)
                                .frame(maxWidth: 320)
//                        }
                        }
                        Text(xTitle).padding()
                    }
                }.padding(.vertical)
                    .padding(.horizontal, 30)
            }
        }
        
    }
    func getBarWidth() -> CGFloat {
        var width: CGFloat = 300
        let listSize: CGFloat = CGFloat(viewModel.list.count)
        let spaces: CGFloat = 6 * listSize
        width -= spaces
        let elementSize = (width / listSize)
//        print("Tamanho da tela \(UIScreen.main.bounds.size.width)")
//        print("Tamanho da lista \(CGFloat(viewModel.list.count))")
//        print("Tela reduzida \(width)")
//        print("Tamanho do elemento\(elementSize)")
//        print("Tamanho Total Utilizado\(elementSize * listSize)")
        return elementSize
        
    }
}


struct BarsChart: View {
    var value: CGFloat
    var width: CGFloat
    var parentHeigth: CGFloat
    var maxValue: CGFloat
    
    var body: some View {
        var w:CGFloat = width
        if width > 30 {
            w = 30
        }
        let multiplier: CGFloat = (self.maxValue / parentHeigth)
        return ZStack(alignment: .bottom) {
            Rectangle().frame(width: w)
                .foregroundColor(Color.black)
            
            Rectangle().frame(width: w)
                .foregroundColor(Color.gray)
                .padding(.bottom, parentHeigth * ((value / multiplier) / parentHeigth))
        }
    }
}

struct ChartBarView_Previews: PreviewProvider {
    static var previews: some View {
        ChartBarView()
    }
}


