//
//  TranslateAPI.swift
//  Baluchon
//
//  Created by fred on 30/12/2021.
//

import Foundation

struct TranslateAPI {

    static var shared = TranslateAPI()
        private init() {}
    
    var apiKey: String = Bundle.main.infoDictionary?["TRANSLATE_API_KEY"] as? String ?? ""
    init(apiKey: String) {
        self.apiKey = apiKey
    }

    let format = "text"

    func getUrl(inputText: String, sourceLang: String, targetLang: String) -> URL? {
        
        var component = URLComponents()
        component.scheme = "https"
        component.host = "translation.googleapis.com"
        component.path = "/language/translate/v2"
        component.queryItems = [
                URLQueryItem(name: "q", value: inputText),
                URLQueryItem(name: "source", value: sourceLang),
                URLQueryItem(name: "target", value: targetLang),
                URLQueryItem(name: "format", value: format),
                URLQueryItem(name: "key", value: apiKey)
        ]
        return component.url
    }
}
