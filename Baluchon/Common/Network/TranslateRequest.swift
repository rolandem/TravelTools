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

    private var translateSession = URLSession(configuration: .default)
    init(translateSession: URLSession) {
        self.translateSession = translateSession
    }

    let task = TaskService()

    func getTranslation(inputText: String,
                        sourceLang: String,
                        targetLang: String,
                        callback: @escaping(Result<TranslationResponse,
                                                    TaskService.FetchError>) -> Void) {

        let translateUrl = TranslateAPI.translateText(inputText: inputText,
                                                      sourceLang: sourceLang,
                                                      targetLang: targetLang).url

        guard let translationUrl = translateUrl else {
            print(TaskService.FetchError.wrongUrl)
            return }

        task.taskData(urlSession: translateSession,
                      request: translationUrl,
                      requestDataType: TranslationResponse.self,
                      completionHandler: callback.self)
    }
}
