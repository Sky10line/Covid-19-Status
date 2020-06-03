//
//  Data.swift
//  Covid-19-Status
//
//  Created by Rogerio Lucon on 23/05/20.
//  Copyright © 2020 Rodrigo-Rogerio. All rights reserved.
//
import UIKit
import SwiftUI
import CoreLocation

var tipsData: [Tip] = load("tipsData.json")

struct Tip: Hashable, Codable, Identifiable {
    let id: Int
    let imgName: String
    let title: String
    let text: String
    let source: String
}

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}
