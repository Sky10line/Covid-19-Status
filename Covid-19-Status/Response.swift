//
//  Response.swift
//  Covid-19-Status
//
//  Created by Rodrigo Ryo Aoki on 22/05/20.
//  Copyright © 2020 Rodrigo-Rogerio. All rights reserved.
//

import Foundation

struct Response: Codable {
    let state: String
    let cases: Int
    let deaths: Int
    let suspects: Int
    let refuses: Int
}
