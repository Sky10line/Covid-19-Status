//
//  HomeTipsView.swift
//  Covid-19-Status
//
//  Created by Rogerio Lucon on 22/05/20.
//  Copyright © 2020 Rodrigo-Rogerio. All rights reserved.
//

import SwiftUI


struct HomeTipsList: View {
    
    var tips = tipsData
    
    var body: some View {
        VStack {
            Text("Dicas").font(.largeTitle).padding(.top)
            ForEach(0..<tips.count) { index in
                if index % 2 == 0 {
                    HomeTipsRow(tips: self.tips, index: index)
                }
            }
        }
        .background(BackgroundRect())
    }
    
}

struct HomeTipsRow: View {
    
    let tips: [Tip]
    let index: Int
    let size: (w: CGFloat, h:CGFloat) = (w: 150, h: 200)

    var body: some View {
        HStack {
            Spacer()
            CellTips(tip: tips[index])
            Spacer()
            if index + 1 < tips.count{
                CellTips(tip: tips[index + 1])
                
            }else{
                Text("").frame(width: size.w, height: size.h)
                .background(Color.clear)
            }
            Spacer()
        }.padding()
    }

}

struct CellTips: View {
    
    let tip: Tip
    let size: (w: CGFloat, h:CGFloat) = (w: 150, h: 200)
    
    var body: some View {
        NavigationLink(destination: TipsView(tip: tip)){
            ZStack(alignment: .bottom){
                Text("").frame(width: size.w, height: size.h)
                    .background(Color.lightSteelBlue)
                    .cornerRadius(25)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(
                                RadialGradient(gradient:
                                    Gradient(colors: [.darkSteelBlue, .steelBlue]), center: .center, startRadius: 1, endRadius: 150)
                            , lineWidth: 10))
                    
                Text(tip.title).frame(width: 120)
                    .font(.headline)
                    .foregroundColor(Color.black)
                    .offset(y: -16)
            }
        }
    }
}

struct BackgroundRect: View {
    
    var color: Color = .lightSteel
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
            .fill(self.color)
        }
    }
}


struct HomeTipsView_Previews: PreviewProvider {
    static var previews: some View {
        HomeTipsList()
    }
}
