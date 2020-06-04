//
//  DataService.swift
//  Covid-19-Status
//
//  Created by Rogerio Lucon on 27/05/20.
//  Copyright © 2020 Rodrigo-Rogerio. All rights reserved.
//
import Foundation

class DataService {
    
    private static let localFileName = "teste.json"
    private static let url = "https://covid19-brazil-api.now.sh/api/report/v1"
    private static let stateURL = "https://covid19-brazil-api.now.sh/api/report/v1/brazil/uf"
    private static let brasilURL = "https://covid19-brazil-api.now.sh/api/report/v1/brazil"
    private static let allContriesURL = "https://covid19-brazil-api.now.sh/api/report/v1/countries"
    private static let statesByDateURL = "https://covid19-brazil-api.now.sh/api/report/v1/brazil"
    
    private static let connectionCheck = ConnectionCheck()
    
    public static let fistDayBrazil = "20200130"
    
    static var localData: AllInfos {
        get{
            if fileExists(filename: localFileName) {
                let aux: AllInfos = loadDinamicFile(localFileName)
                return aux
            } else {
                let aux: AllInfos = load("localData.json")
                return aux
            }
        } set {}
    }
    
    static func getAllContries() -> Countries{
        if connectionCheck.isConnection  && isUpdated() {
        updateLocalData()
            return request(allContriesURL)
        }
        return Countries(data: localData.countries)
    }
    
    static func getCountry(_ country: String) -> ByCountry? {
        if connectionCheck.isConnection  && isUpdated() {
        updateLocalData()
            return request("\(url)/\(country)")
        }
        for countryObj in localData.countries {
            if countryObj.country.uppercased() == country.uppercased() {
                return ByCountry(data: countryObj)
            }
        }
        return nil
    }
    
    static func getAllStates() -> Brazil {
        if connectionCheck.isConnection  && isUpdated() {
        updateLocalData()
            return request(url)
        }
        return Brazil(data: localData.states)
    }
    
    static func getAllStatesByDate(_ date: String) -> Brazil{
        return request("\(statesByDateURL)/\(date)")
    }
    
    static func getState(_ state: String) -> BrazilianState? {
        if connectionCheck.isConnection  && isUpdated() {
            updateLocalData()
            return request("\(stateURL)/\(state)")
        }
        for stateObj in localData.states {
            if stateObj.uf == state.uppercased() {
                    return stateObj
                }
            }
            return nil
        }
    
    static func getStateByDateRange(state: String, start: String, end: String) -> [BrazilianState] {
        var list: [BrazilianState] = []
        let start: Int = Int(start) ?? 0
        let end: Int = Int(end) ?? 0
        for i in start...end {
            let estados:[BrazilianState] = DataService.getAllStatesByDate("\(i)").data
            let filter: [BrazilianState] = estados.filter {
                $0.uf == state.uppercased()
            }
            list.append(contentsOf: filter)
        }
        return list
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
    
    private static func updateLocalData() {
        let date = Date()
        let countries = DataService.getAllContries()
        let states = DataService.getAllStates()
        
        let lastAllInfos = AllInfos(lastUpdate: "\(date)", countries: countries.data, states: states.data)
        localData = lastAllInfos
        save(data: lastAllInfos, filename: localFileName)
    }
    
    private static func isUpdated() -> Bool {
        let lastUpdate = dateStringToDate(date: localData.lastUpdate)
        let elapsed = Date().timeIntervalSince(lastUpdate)
        
        let min  = (elapsed / 6.0) / 100000.0
        
        if min > 60 {
            return true
        } else {
            return false
        }
        
    }
    
    private static func dateStringToDate(date: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss ZZZ"
        let date = dateFormatter.date(from:date)!

        return date
    }
}
