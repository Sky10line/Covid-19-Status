//
//  DropDownMenu.swift
//  Covid-19-Status
//
//  Created by Rodrigo Ryo Aoki on 26/05/20.
//  Copyright © 2020 Rodrigo-Rogerio. All rights reserved.
//

import SwiftUI

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
            
            Button(action: {self.expand = false; self.name = "Select 2"}) {
                
                Text("Select 2").padding()
                
            }.foregroundColor(.black)
            
            Button(action: {self.expand = false; self.name = "Select 3"}) {
                
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

struct DropDownMenu_Previews: PreviewProvider {
    static var previews: some View {
        DropDownMenu()
    }
}
