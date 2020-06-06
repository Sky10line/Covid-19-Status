//
//  TipsMainView.swift
//  Covid-19-Status
//
//  Created by Rogerio Lucon on 30/05/20.
//  Copyright © 2020 Rodrigo-Rogerio. All rights reserved.
//

import SwiftUI

class TipsViewModel: ObservableObject {
    private let tips: [Tip] = tipsData
    @Published var leftList: [Tip] = []
    @Published var rightList: [Tip] = []
    
    init() {
        splitArray(list: tips)
    }
    
    func filterList(searcTerm: String) {
        print("Change filter")
        let filtredList = self.tips.filter {
            return searcTerm.isEmpty ? true : $0.title.contains(searcTerm)
        }
        leftList = []
        rightList = []
        splitArray(list: filtredList)
    }
    
    func splitArray(list: [Tip]){
        for i in 0...list.count - 1 {
            if i % 2 == 0 {
                leftList.append(list[i])
            } else{
                rightList.append(list[i])
            }
        }
        
    }
}

struct TipsMainView: View {
    
    @Environment(\.localStatusBarStyle) var statusBarStyle
    @ObservedObject var model = TipsViewModel()
    @State var searchTerm: String = ""
    
    var tips = tipsData
    let bgColor = Color.white
    let cellColor = Color.secondary
    
    var body: some View {
        statusBarStyle.currentStyle = .darkContent
        return NavigationView{
            VStack{
                HStack {
                    VStack {
                        Rectangle()
                            .fill(bgColor)
                            .frame(height: 24)
                        HStack {
                            Text("Dicas").font(.title).bold()
                            Spacer()
                        }
                    }.padding()
                }.zIndex(1)
                    .background(bgColor)
                ScrollView {
                    VStack {
                        SearchBar(text: $searchTerm, model: model).zIndex(1).padding()
                        
                        HStack {
                            Spacer()
                            VStack {
                                ForEach(model.leftList, id: \.self) { tip in
                                        CellTips(tip: tip, cellcColor: self.cellColor, foregroundColor: Color.black).padding(.vertical)
                                }
                            }
                            Spacer()
                            VStack {
                                ForEach(model.rightList, id: \.self) { tip in
                                    CellTips(tip: tip, cellcColor: self.cellColor, foregroundColor: Color.black).padding(.vertical)
                                }
                                if model.rightList.count < model.leftList.count {
                                    Text("").frame(width: 150, height: 200)
                                        .background(Color.clear)
                                        .padding(.vertical)
                                }
                            }
                            Spacer()
                        }
                        
                        Button(action: {
                            UIApplication.shared.open(URL(string: "https://coronavirus.saude.gov.br")!)
                        }){
                            CustomButton(txt: "Informações oficiais")
                        }
                    }
                }.zIndex(0)
            }.background(bgColor)
                .edgesIgnoringSafeArea(.top)
        }
        .navigationBarTitle("Dicas")
        .navigationBarHidden(true)
        
    }
}

struct TipsMainViewHeader: View {
    
    var tips = tipsData
    let bgColor = Color.white
    
    var body: some View {
        //        ZStack{
        VStack {
            Rectangle()
                .fill(bgColor)
                .frame(height: 24)
            HStack {
                Text("Dicas").font(.title).bold()
                Spacer()
                //                    Rectangle().frame(height: 32)
                //                    SearchBar()
            }.padding()
        }
        //        }
        
    }
}

struct TipsMainView_Previews: PreviewProvider {
    static var previews: some View {
        TipsMainView()
    }
}
