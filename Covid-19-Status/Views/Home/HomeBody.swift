//
//  HomeTipsView.swift
//  Covid-19-Status
//
//  Created by Rogerio Lucon on 22/05/20.
//  Copyright © 2020 Rodrigo-Rogerio. All rights reserved.
//

import SwiftUI


struct HomeBody: View {
    
    var tips = tipsData
    @State var listSize: Int = 0
    var appData: AppData
    var txtColor = Color(red: 0.1608, green: 0.1647, blue: 0.1843, opacity: 1.0) // color.secondary
    
    var body: some View {
        if listSize == 0 {
            listSize = tips.count
        }
        return VStack(alignment: .center, spacing: 18, content: {
            
            Text("Dados").font(.system(size: 40, weight: .bold, design: .default))
                .padding(.top)
                .foregroundColor(txtColor)

            //Botao que muda a selecao da tab bar
            Button(action: {
                self.appData.tabSelec = 2
            }){
                
                CellDataRec()
                    .foregroundColor(.black)
                
            }
            Text("Dicas").font(.system(size: 40, weight: .bold, design: .default))
                .padding(.top)
            .foregroundColor(txtColor)
            ForEach(0..<listSize) { index in
                if index % 2 == 0 {
                    HomeTipsRow(tips: self.tips, index: index)
                }
            }

            Button(action: {
                self.appData.tabSelec = 1
            }){
                CustomButton(txt: "Ver mais dicas")
            }
        })
        .background(BackgroundRect())
    }
    
}

struct CustomButton: View {
    
    var bgColor = Color(red: 0.3412, green: 0.4353, blue: 0.7647, opacity: 1.0)
    var txt: String
    var body: some View{
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(bgColor)
                .frame(width: 320, height: 50)
            Text(txt).font(.title).fontWeight(.bold)
        }
        .foregroundColor(.white)
        .padding()
    }
}

struct HomeTipsRow: View {
    
    let tips: [Tip]
    let index: Int
    let size: (w: CGFloat, h:CGFloat) = (w: 150, h: 200)
    var cellColor: Color = Color.secondary
    var cellForegroundColor: Color = Color.black
    let icons = ["tips1", "covid2"]
    var body: some View {
        HStack {
            Spacer()
            
            CellTips(tip: tips[index], cellcColor: cellColor,foregroundColor: cellForegroundColor)
            Spacer()
            if index + 1 < tips.count {
                CellTips(tip: tips[index + 1], cellcColor: cellColor, foregroundColor: cellForegroundColor)
            }else{
                Text("").frame(width: size.w, height: size.h)
                    .background(Color.clear)
            }
            Spacer()
        }.padding([.horizontal,.top])
    }
    
}

struct CellTips: View {
    
    let tip: Tip
    let size: (w: CGFloat, h:CGFloat) = (w: 150, h: 200)
    var cellcColor: Color = Color(red: 0.6196, green: 0.7569, blue: 0.9059, opacity: 1.0)
    let foregroundColor: Color
    var body: some View {
        NavigationLink(destination: TipView(tip: tip)){
            ZStack(alignment: .bottom){
                Text("").frame(width: size.w, height: size.h)
                    .background(cellcColor)
                    .cornerRadius(25)
                
                Text(tip.title).frame(width: 120)
                    .font(.headline)
                    .foregroundColor(foregroundColor)
                    .offset(y: -16)
            }
        }
    }
}

struct BackgroundRect: View {
    
    var startColor: Color = .primary
    
    var tl: CGFloat = 30
    var tr: CGFloat = 30
    var bl: CGFloat = 0.0
    var br: CGFloat = 0.0
    
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                
                let w = geometry.size.width
                let h = geometry.size.height
                
                // Make sure we do not exceed the size of the rectangle
                let tr = min(min(self.tr, h/2), w/2)
                let tl = min(min(self.tl, h/2), w/2)
                let bl = min(min(self.bl, h/2), w/2)
                let br = min(min(self.br, h/2), w/2)
                
                path.move(to: CGPoint(x: w / 2.0, y: 0))
                path.addLine(to: CGPoint(x: w - tr, y: 0))
                path.addArc(center: CGPoint(x: w - tr, y: tr), radius: tr, startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 0), clockwise: false)
                path.addLine(to: CGPoint(x: w, y: h - br))
                path.addArc(center: CGPoint(x: w - br, y: h - br), radius: br, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90), clockwise: false)
                path.addLine(to: CGPoint(x: bl, y: h))
                path.addArc(center: CGPoint(x: bl, y: h - bl), radius: bl, startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 180), clockwise: false)
                path.addLine(to: CGPoint(x: 0, y: tl))
                path.addArc(center: CGPoint(x: tl, y: tl), radius: tl, startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 270), clockwise: false)
            }
            .fill(Color.white)
        }
    }
}

struct HomeTipsView_Previews: PreviewProvider {
    static var previews: some View {
        MainView().environmentObject(AppData())
//                HomeBody(appData: AppData())
//        CustomButton()
        //        Text("")
    }
}
