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
        list = chageList()
        maxValue = list.max()!
        }}
    @Published var list: [CGFloat]
    @Published var maxValue: CGFloat
    let fullList: [CGFloat]
    
    init(list: [CGFloat]) {
        self.fullList = list
        self.list = fullList.suffix(7)
        self.maxValue = fullList.max()!
    }
    
    func chageList() -> [CGFloat]{
        if selected == 0 {
            return fullList.suffix(7)
        }
        if selected == 1 {
            return fullList.suffix(15)
        }
        return fullList
    }
}

struct ChartBarView: View {
    
    @ObservedObject var viewModel: ChartViewModel
    @State var title: String = "Nome do grafico"
    @State var xTitle: String = "Parametro x"
    @State var yTitle: String = "Parametro y"
    var line: Bool = false
    
    var body: some View {
        
        ZStack {
            Color(.gray).edgesIgnoringSafeArea(.all)
            
            VStack {
                Text(title).font(.title)
                
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
                            ChartBar(list: viewModel.list, maxValue: viewModel.maxValue)
                        }
                        Text(xTitle).padding()
                    }
                    Picker(selection: $viewModel.selected, label: Text("")) {
                        Text("Semana").tag(0)
                        Text("Quinzena").tag(1)
                        Text("Mes").tag(2)
                    }.pickerStyle(SegmentedPickerStyle())
                        .padding(.horizontal)
                }.padding(.vertical)
                    .padding(.horizontal, 30)
            }
        }
        
    }
    
    init(list: [CGFloat]) {
        viewModel = ChartViewModel(list: list)
    }
    
    
    
}

struct ChartBar:  View {
    
    let list: [CGFloat]
    let maxValue: CGFloat
    
    var body: some View {
        ZStack {
            if list.count > 20 {
                ScrollView(.horizontal) {
                    HStack(alignment: .bottom, spacing: 6) {
                        ForEach(0..<list.count, id: \.self) { i in
                            VStack {
                                BarsChart(value: self.list[i], width: self.getBarWidth(self.list), parentHeigth: 300, maxValue: self.maxValue)
                                if i % 4 == 0 {
                                Text("12/04").font(.caption)
                                    .frame(width: 50, height: 30)
                                    .rotationEffect(Angle(degrees: -45))
                                    .padding(.top, 6)
                                } else {
                                    Text("12/04").font(.caption)
                                    .frame(width: 50, height: 30)
                                    .rotationEffect(Angle(degrees: -45))
                                    .padding(.top, 6)
                                        .foregroundColor(.clear)
                                }
                            }.frame(width: self.getBarWidth(self.list) + 4)
                            
                        }
                    }
                }.frame(height: 300)
                    .frame(maxWidth: 320)
            } else {
                HStack(alignment: .bottom, spacing: 6) {
                    ForEach(list.indices, id: \.self) { i in
                        VStack {
                            BarsChart(value: self.list[i], width: self.getBarWidth(self.list), parentHeigth: 300, maxValue: self.maxValue)
                            
                            Text("12/04").font(.caption)
                                .frame(width: 50, height: 30)
                                .rotationEffect(Angle(degrees: -45))
                                .padding(.top, 6)
                        }.frame(width: self.getBarWidth(self.list))
                    }
                }
                .frame(height: 300)
                .frame(maxWidth: 320)
            }
        }
    }
    
    func getBarWidth(_ list: [Any]) -> CGFloat {
        var width: CGFloat = 300
        let listSize: CGFloat = CGFloat(list.count)
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
        } else if width < 10 {
            w = 10
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
        ChartBarView(list: [1,2,3,4,5,6,7,14,21,42,82,100,120,160,200,1,2,3,4,5,6,7,14,21,42,82,100,120,160,300])
    }
}


