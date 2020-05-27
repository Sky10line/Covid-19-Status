//
//  DataService.swift
//  Covid-19-Status
//
//  Created by Rogerio Lucon on 27/05/20.
//  Copyright © 2020 Rodrigo-Rogerio. All rights reserved.
//
import Foundation

class DataService {
    
    private static let url = "https://covid19-brazil-api.now.sh/api/report/v1"
    private static let state = "https://covid19-brazil-api.now.sh/api/report/v1/brazil/uf"
    private static let brasil = "https://covid19-brazil-api.now.sh/api/report/v1/brazil"
    private static let allContries = "https://covid19-brazil-api.now.sh/api/report/v1/countries"
    
    static func getAllContries() -> Countries{
        return request(allContries)
    }
    
    static func getCountry(_ country: String) -> ByCountry {
        return request("\(url)/\(country)")
    }
    
    static func getAllStates() -> Brazil {
        return request(url)
    }
    
    static func getState(_ state: String) -> BrazilianState {
        return request("\(state)/\(state)")
    }
    
    private static func request<T:Decodable>(_ teste: String) -> T {
        var res: T!
        let group = DispatchGroup()
        group.enter()
        if let url = URL(string: teste ){
            URLSession.shared.dataTask(with: url){
                data, response, error in
                if let data = data{
                    do{
                        let teste: T = try JSONDecoder().decode(T.self, from: data)
                        res = teste
                    } catch let erro{
                        print(erro)
                    }
                }
                group.leave()
            }.resume()
        }
        group.wait()
        return res
    }
}
