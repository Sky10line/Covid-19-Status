//
//  SearchBar.swift
//  Covid-19-Status
//
//  Created by Rogerio Lucon on 31/05/20.
//  Copyright © 2020 Rodrigo-Rogerio. All rights reserved.
//

import SwiftUI

struct SearchBar: UIViewRepresentable {
    
    @Binding var text: String
    var model: TipsViewModel
    
    class Coordinator: NSObject, UISearchBarDelegate {
        
        @Binding var text: String
        var model: TipsViewModel
        
        init(text: Binding<String>, model: TipsViewModel) {
            _text = text
            self.model = model
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
            model.filterList(searcTerm: text)
            print("textDidChange")
        }
        
    }
    
    func makeCoordinator() -> SearchBar.Coordinator {
        return Coordinator(text: $text, model: model)
    }
    
    func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        return searchBar
    }
    
    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBar>) {
        uiView.text = text
    }
}

//struct SearchBar_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchBar()
//    }
//}
