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
    let title: String
    let text: String
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

func loadDinamicFile<T: Decodable>(_ filename: String) -> T {
    let data: Data
    
    if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
        let file = dir.appendingPathComponent(filename)
        
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
        
    } else {
            fatalError("Couldn't find \(filename) in main bundle.")
    }
}

func save<T: Encodable>(data: T, filename: String) {
    let encoder = JSONEncoder()
    // 1
    guard let jsonData = try? encoder.encode(data)
        else{
            fatalError("Couldn't parse \(filename) in main bundle.")
    }
    // 2
    let text =  String(data: jsonData, encoding: .utf8)!
    
    if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
        print(dir)
        let fileURL = dir.appendingPathComponent(filename)

        do {
            try text.write(to: fileURL, atomically: false, encoding: .utf8)
        }
        catch {fatalError("File \(filename) can`t be save")}
    }
}

func fileExists(filename: String) -> Bool {
    if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
        let fileURL = dir.appendingPathComponent(filename)
        
        let fileManager = FileManager.default
        
        return fileManager.fileExists(atPath: fileURL.path)
    } else {
        return false
    }
}
