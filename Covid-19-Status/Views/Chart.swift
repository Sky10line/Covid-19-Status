//
//  SwiftUIView.swift
//  Covid-19-Status
//
//  Created by Rogerio Lucon on 01/06/20.
//  Copyright © 2020 Rodrigo-Rogerio. All rights reserved.
//

import SwiftUI

class ChartViewModel: ObservableObject {
    @Published var selected: Int = 0 {didSet {chageList()
        }}
    @Published var numberList: [CGFloat]{didSet{maxValue = numberList.max()!}}
    @Published var maxValue: CGFloat
    @Published var dateList: [String]
    var fullDateList: [String]
    var fullNumberList: [CGFloat]
    
    init(numberList: [CGFloat], dateList: [String]) {
        self.fullNumberList = numberList
        self.fullDateList = dateList
        self.numberList = fullNumberList.suffix(7)
        self.dateList = fullDateList.suffix(7)
        self.maxValue = fullNumberList.max()!
    }
    
    func chageList() {
        if selected == 0 {
            numberList =  fullNumberList.suffix(7)
            dateList =  fullDateList.suffix(7)
        }else if selected == 1 {
            numberList = fullNumberList.suffix(15)
            dateList =  fullDateList.suffix(15)
        } else {
            numberList = fullNumberList
            dateList =  fullDateList
        }
    }
}

struct ChartBarView: View {
    
    @ObservedObject var viewModel: ChartViewModel
    var title: String = "Nome do grafico"
    var xTitle: String = "Parametro x"
    var yTitle: String = "Parametro y"
    
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
                            ChartBar(numberList: viewModel.numberList,dateList: viewModel.dateList, maxValue: viewModel.maxValue)
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
    
    init(numberList: [CGFloat], dateList: [String]) {
        viewModel = ChartViewModel(numberList: numberList, dateList: dateList)
    }
    
    
    
}

struct ChartBar:  View {
    
    let numberList: [CGFloat]
    let dateList: [String]
    let maxValue: CGFloat
    
    var body: some View {
        ZStack {
            if numberList.count > 20 {
                ScrollView(.horizontal) {
                    HStack(alignment: .bottom, spacing: 6) {
                        ForEach(0..<numberList.count, id: \.self) { i in
                            VStack {
                                BarsChart(value: self.numberList[i], width: self.getBarWidth(self.numberList), parentHeigth: 300, maxValue: self.maxValue)
                                if i % 5 == 0 {
                                    Text("\(self.dateList[i])").font(.caption)
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
                            }.frame(width: self.getBarWidth(self.numberList) + 4)
                            
                        }
                    }
                }.frame(height: 300)
                    .frame(maxWidth: 320)
            } else {
                HStack(alignment: .bottom, spacing: 6) {
                    ForEach(numberList.indices, id: \.self) { i in
                        VStack {
                            BarsChart(value: self.numberList[i], width: self.getBarWidth(self.numberList), parentHeigth: 300, maxValue: self.maxValue)
                            
                            Text("\(self.dateList[i])").font(.caption)
                                .frame(width: 50, height: 30)
                                .rotationEffect(Angle(degrees: -45))
                                .padding(.top, 6)
                        }.frame(width: self.getBarWidth(self.numberList))
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
        ChartBarView(numberList: [1,2,3,4,5,6,7,14,21,42,82,100,120,160,200,1,2,3,4,5,6,7,14,21,42,82,100,120,160,300,1],
        dateList: ["01/01","02/01","03/01","04/01","05/01","06/01","07/01","08/01","09/01","10/01","11/01","12/01","13/01","14/01","15/01","16/01","17/01","18/01","19/01","20/01","21/01","22/01","23/01","24/01","25/01","26/01","27/01","28/01","29/01","30/01","31/01"])
    }
}


