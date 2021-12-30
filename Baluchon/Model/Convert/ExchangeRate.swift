//
//  ExchangeRates.swift
//  Baluchon
//
//  Created by fred on 29/12/2021.
//

import Foundation

struct ExchangeRate: Decodable {
    
    var timestamp: Int
    var rate: UsdRate
}

enum RateError: Error {
    case error(error: Error?)
    case missingData
    case cannotProcessData
    case wrongUrl
}
