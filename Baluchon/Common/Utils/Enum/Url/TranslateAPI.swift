//
//  TranslateAPI.swift
//  Baluchon
//
//  Created by fred on 30/12/2021.
//

import Foundation

    private let apiKey = ""
    private let format = "text"

enum TranslateAPI {
    case translateText(inputText: String, sourceLang: String, targetLang: String)

    var url: URL? {
        var component = URLComponents()
        component.scheme = "https"
        component.host = "translation.googleapis.com"
        component.path = "/language/translate/v2"
        component.queryItems = translateQuery()
        return component.url
    }

    private func translateQuery()-> [URLQueryItem]? {
        switch self {
        case .translateText(inputText: let inputText, sourceLang: let sourceLang, targetLang: let targetLang):
            return [
                URLQueryItem(name: "q", value: inputText),
                URLQueryItem(name: "source", value: sourceLang),
                URLQueryItem(name: "target", value: targetLang),
                URLQueryItem(name: "format", value: format),
                URLQueryItem(name: "key", value: apiKey)
            ]
        }
    }
}
