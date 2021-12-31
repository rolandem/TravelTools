//
//  Temperature.swift
//  Baluchon
//
//  Created by fred on 28/12/2021.
//

import Foundation

struct TemperatureData: Decodable {
    let temperature: Double
    
    enum CodingKeys: String, CodingKey {
        case temperature = "temp"
        
    }
}
