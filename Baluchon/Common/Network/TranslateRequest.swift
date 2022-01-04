//
//  TranslateRequest.swift
//  Baluchon
//
//  Created by fred on 30/12/2021.
//

import Foundation

class TranslateRequest {

    static var shared = TranslateRequest()
    private init(){}

    private var task: URLSessionDataTask?

    private var translateSession = URLSession(configuration: .default)
    init(translateSession: URLSession) {
        self.translateSession = translateSession
    }

    func getTranslation(inputText: String,
                               sourceLang: String,
                               targetLang: String,
                               callback: @escaping(Result<TranslationResponse, TranslateError>) -> Void) {
        
        let translateUrl = TranslateAPI.translateText(inputText: inputText,
                                                      sourceLang: sourceLang,
                                                      targetLang: targetLang).url
        
        guard let translationUrl = translateUrl else {
            print(TranslateError.wrongUrl)
            return }

        task?.cancel()
        task = translateSession.dataTask(with: translationUrl) { (data, response, error) in
            DispatchQueue.main.async {

                guard let data = data, error == nil else {
                    callback(.failure(.missingData))
                    return
                    }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(.failure(.missingData))
                    return
                    }
                do {
                    let translatedText = try JSONDecoder().decode(TranslationResponse.self, from: data)
                    print("translated", translatedText)
                    callback(.success(translatedText))
                } catch {
                    callback(.failure(.cannotProcessData))
// msg alert non trouvé - ajout tiret dans nom composé
                }
            }
        }
        task?.resume()
    }
}
