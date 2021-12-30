//
//  TranslateRequest.swift
//  Baluchon
//
//  Created by fred on 30/12/2021.
//

import Foundation

class TranslateRequest {

    static func getLTranslation(inputText: String, sourceLang: String, targetLang: String, callback: @escaping(Result<TranslationResponse, TranslateError>) -> Void) {
        
        let session = URLSession(configuration: .ephemeral)
        let translateUrl = TranslateAPI.translateText(inputText: inputText, sourceLang: sourceLang, targetLang: targetLang).url
        
        guard let translationUrl = translateUrl else {
            print(TranslateError.wrongUrl)
            return }
        
print("translationUrl =", translationUrl)
        
        session.dataTask(with: translationUrl) { (data, response, error) in
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
                    callback(.success(translatedText))
                } catch {
                    callback(.failure(.cannotProcessData))
// msg alert non trouvé - ajout tiret dans nom composé
                }
            }
        }.resume()
    }
}
