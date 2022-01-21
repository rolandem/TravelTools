//
//  ExchangeRates.swift
//  Baluchon
//
//  Created by fred on 29/12/2021.
//

import Foundation

struct Rate: Decodable {

    enum MainKeys: String, CodingKey {
        case timestamp
        case rates

        enum RatesKeys: String, CodingKey {
            case USD
        }
    }

    var timestamp: Int
    var USD: Double

    init(from decoder: Decoder) throws {
        /// main container
        let container = try decoder.container(keyedBy: MainKeys.self)
        self.timestamp = try container.decode(Int.self, forKey: .timestamp)

        let RatesContainer = try container.nestedContainer(keyedBy: MainKeys.RatesKeys.self, forKey: .rates)
        self.USD = try RatesContainer.decode(Double.self, forKey: .USD)
    }
}
