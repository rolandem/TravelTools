//
//  TranslationData.swift
//  Baluchon
//
//  Created by fred on 30/12/2021.
//

import Foundation

struct TranslationResponse: Decodable {
    let translationData: TranslationData
    
    enum CodingKeys: String, CodingKey {
        case translationData = "data"
    }
}

enum TranslateError: Error {
    case missingData
    case cannotProcessData
    case wrongUrl
}
