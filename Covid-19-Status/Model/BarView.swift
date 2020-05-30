//
//  BarChart.swift
//  Covid-19-Status
//
//  Created by Rodrigo Ryo Aoki on 29/05/20.
//  Copyright © 2020 Rodrigo-Rogerio. All rights reserved.
//

import SwiftUI

struct BarView: View {
    var value: CGFloat
    var body: some View {
        ZStack(alignment: .bottom){
            Capsule().frame(width: 30, height: 200).foregroundColor(Color(#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)))
            Capsule().frame(width: 30, height: value).foregroundColor(Color(#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)))
        }
    }
}

struct BarChart_Previews: PreviewProvider {
    static var previews: some View {
        BarView(value: 100)
    }
}
