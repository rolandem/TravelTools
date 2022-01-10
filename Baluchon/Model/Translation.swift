//
//  TranslationData.swift
//  Baluchon
//
//  Created by fred on 30/12/2021.
//

import Foundation

struct Translation: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case data

        enum DataKeys: String, CodingKey {
            case translations

            enum TranslationsKeys: String, CodingKey {
                case translatedText
            }
        }
    }

    let translatedText: String
    
    init(from decoder: Decoder) throws {

        let container = try decoder.container(keyedBy: CodingKeys.self)
        // data container
        let dataContainer = try container.nestedContainer(keyedBy: CodingKeys.DataKeys.self, forKey: .data)
        // translations container
        var translateContainer = try dataContainer.nestedUnkeyedContainer(forKey: .translations)
        let firstTranslateContainer = try translateContainer.nestedContainer(keyedBy: CodingKeys.DataKeys.TranslationsKeys.self)
        self.translatedText = try firstTranslateContainer.decode(String.self, forKey: .translatedText)
    }
}
