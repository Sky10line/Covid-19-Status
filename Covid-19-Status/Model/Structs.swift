//
//  Structs HTTP Request.swift
//  Covid-19-Status
//
//  Created by Rogerio Lucon on 27/05/20.
//  Copyright © 2020 Rodrigo-Rogerio. All rights reserved.
//

struct Countries: Codable {
    let data: [Country]
}

struct ByCountry: Codable {
    var data: Country
}

struct Country: Codable {
    let country: String
    let cases: Int
    let deaths: Int
    let recovered: Int
    let updated_at: String

}

struct Brazil: Codable {
    let data: [BrazilianState]
}

struct BrazilianState: Hashable, Codable, Identifiable {
    var id: Int
    let uid: Int
    let uf: String
    let state: String
    let cases: Int
    let deaths: Int
    let suspects: Int
    let refuses: Int
    let datetime: String
}

struct AllInfos: Codable {
    let lastUpdate: String
    let countries: [Country]
    let states: [BrazilianState]
}
