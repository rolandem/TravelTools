//
//  TranslateRepository.swift
//  Baluchon
//
//  Created by fred on 20/01/2022.
//

import Foundation

typealias TranslationOrError = (_ translation: String, _ error: Error?) -> Void

class TranslateRepository {

    static var shared = TranslateRepository()
        private init() {}

    var apiKey: String = (Bundle.main.infoDictionary?["TRANSLATE_API_KEY"] as? String).orEmpty
    let format = "text"

    /// to test getUrl method with a fake apiKey
    init(apiKey: String) {
        self.apiKey = apiKey
    }

    func getTranslation(
        for text: String,
        sourceLanguage: String,
        targetLanguage: String,
        completion: @escaping TranslationOrError
    ) {

        let translateUrl = getUrl(
            inputText: text,
            sourceLang: sourceLanguage,
            targetLang: targetLanguage
        )
        guard let url = translateUrl else {
            completion("", nil)
            return
        }

        APIService.shared.getData(
            request: url,
            dataType: TranslationData.self
        ) { result in
            switch result {
            case .failure(let error) :
                completion("", error)
            case .success(let input) :
                completion(input.translatedText, nil)
            }
        }
    }
}
extension TranslateRepository {

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
