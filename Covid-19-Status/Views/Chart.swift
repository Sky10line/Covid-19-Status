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
    @Published var numberList: [CGFloat]
    @Published var maxValue: CGFloat
    @Published var minValue: CGFloat
    @Published var dateList: [String]
    var fullDateList: [String]
    var fullNumberList: [CGFloat]
    
    init(numberList: [CGFloat], dateList: [String]) {
        self.fullNumberList = numberList.reversed()
        self.fullDateList = dateList.reversed()
        self.numberList = fullNumberList.suffix(7)
        self.dateList = fullDateList.suffix(7)
        self.maxValue = numberList.max()!
        self.minValue = numberList.min()!
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
        maxValue = numberList.max()!
        minValue = numberList.min()!
    }
}

struct ChartBarView: View {
    
    @ObservedObject var viewModel: ChartViewModel
    var title: String = "Nome do grafico"
    var xTitle: String = "Parametro x"
    var yTitle: String = "Parametro y"
    
    var body: some View {
        
        ZStack {
//            Color(.gray).edgesIgnoringSafeArea(.all)
            
            VStack {
                Text(title).font(.title)
                
                VStack(alignment: .leading) {
                    
                    VStack {
                        HStack(alignment: .center) {
                            
                            Spacer()
                            ChartBar(numberList: viewModel.numberList,dateList: viewModel.dateList, maxValue: viewModel.maxValue, minValue: viewModel.minValue, yTitle: yTitle)
                        }
                        Text(xTitle).padding(.top, 24)
                    }
                    Picker(selection: $viewModel.selected, label: Text("")) {
                        Text("Semana").tag(0)
                        Text("Quinzena").tag(1)
                        Text("Mes").tag(2)
                    }.pickerStyle(SegmentedPickerStyle())
                        .padding(.horizontal)
                }.padding(.vertical)
//                    .padding(.horizontal, 30)
            }
        }
        
    }
    
    init(numberList: [CGFloat], dateList: [String], title: String?, xTitle: String?,yTitle: String?) {
        viewModel = ChartViewModel(numberList: numberList, dateList: dateList)
        self.title = title ?? self.title
        self.xTitle = xTitle ?? self.xTitle
        self.yTitle = yTitle ?? self.yTitle
    }
    
    
    
}

struct ChartBar:  View {
    
    let numberList: [CGFloat]
    let dateList: [String]
    let maxValue: CGFloat
    let minValue: CGFloat
    let yTitle: String
    
    var body: some View {
        let dif = maxValue - minValue
        let threeQuarter: CGFloat = (dif / 4) * 3
        let twoQuarter: CGFloat = (dif / 4) * 2
        return ZStack {
            if numberList.count > 20 {
                ScrollView(.horizontal) {
                    HStack(alignment: .bottom, spacing: 6) {
                        Rectangle().frame(width: 20)
                        .foregroundColor(.clear)
                        VStack {
                            Spacer()
                            ZStack {
                                Text(yTitle)
                                    .frame(width: 150)
                                    .lineLimit(1)
                                    .rotationEffect(Angle(degrees: 90))
                            }.frame(width: 0)
                            Spacer()
                        }
                        VStack(alignment: .leading) {
                            Text("\(Int(maxValue).roundedWithAbbreviations)").frame(width: 50)
                                .font(.caption).padding(.bottom, 82)
                            Text("\(Int(threeQuarter).roundedWithAbbreviations)").frame(width: 50)
                            .font(.caption).padding(.bottom, 82)
                            Text("\(Int(twoQuarter).roundedWithAbbreviations)").frame(width: 50)
                                .font(.caption).padding(.bottom, 82)
                            Text("\(Int(minValue).roundedWithAbbreviations)").frame(width: 50)
                            .font(.caption)
                            Rectangle().frame(height: 30)
                                .foregroundColor(.clear)
                        }
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
                    .frame(maxWidth: 300)
            } else {
                
                HStack(alignment: .bottom, spacing: 6) {
                    VStack {
                        Spacer()
                        ZStack {
                            Text(yTitle)
                                .frame(width: 150)
                                .lineLimit(1)
                                .rotationEffect(Angle(degrees: 90))
                        }.frame(width: 0)
                        Spacer()
                    }
                    VStack(alignment: .leading) {
                        Text("\(Int(maxValue).roundedWithAbbreviations)").frame(width: 50)
                            .font(.caption).padding(.bottom, 82)
                        Text("\(Int(threeQuarter).roundedWithAbbreviations)").frame(width: 50)
                        .font(.caption).padding(.bottom, 82)
                        Text("\(Int(twoQuarter).roundedWithAbbreviations)").frame(width: 50)
                            .font(.caption).padding(.bottom, 82)
                        Text("\(Int(minValue).roundedWithAbbreviations)").frame(width: 50)
                        .font(.caption)
                        Rectangle().frame(height: 30)
                            .foregroundColor(.clear)
                    }
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
                .frame(maxWidth: 300)
            }
        }
    }
    
    func getBarWidth(_ list: [Any]) -> CGFloat {
        var width: CGFloat = 280
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
                .foregroundColor(Color(red: 0.3412, green: 0.4353, blue: 0.7647, opacity: 1.0))
            
            Rectangle().frame(width: w)
                .foregroundColor(Color.white.opacity(0.5))
                .padding(.bottom, parentHeigth * ((value / multiplier) / parentHeigth))
        }
    }
}

struct ChartBarView_Previews: PreviewProvider {
    static var previews: some View {
        ChartBarView(numberList: [1,2,3,4,5,6,7,14,21,42,82,100,120,160,200,1,2,3,4,5,6,7,14,21,42,82,100,120,160,300,1].reversed(),
        dateList: ["01/01","02/01","03/01","04/01","05/01","06/01","07/01","08/01","09/01","10/01","11/01","12/01","13/01","14/01","15/01","16/01","17/01","18/01","19/01","20/01","21/01","22/01","23/01","24/01","25/01","26/01","27/01","28/01","29/01","30/01","31/01"], title: nil, xTitle: nil, yTitle: nil)
    }
}


extension Int {
    var roundedWithAbbreviations: String {
        let number = Double(self)
        let thousand = number / 1000
        let million = number / 1000000
        if million >= 1.0 {
            return "\(round(million*10)/10)M"
        }
        else if thousand >= 1.0 {
            return "\(round(thousand*10)/10)K"
        }
        else {
            return "\(self)"
        }
    }
}
