//
//  ConvertRequest.swift
//  Baluchon
//
//  Created by fred on 29/12/2021.
//

import Foundation

class ConvertRequest {

    static var shared = ConvertRequest()
    private init(){}

    private var task: URLSessionDataTask?

    private var rateSession = URLSession(configuration: .default)
    init(rateSession: URLSession) {
        self.rateSession = rateSession
    }

    private let rateUrl = ConvertAPI.convertUrl

    func getRate(callback: @escaping(Result<ExchangeRate, RateError>) -> Void) {

        guard let rateUrl = rateUrl else {
            print(RateError.wrongUrl)
            return }

        task?.cancel()
        task = rateSession.dataTask(with: rateUrl) { (data, response, error) in
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
                    let rateData = try JSONDecoder().decode(ExchangeRate.self, from: data)
                    callback(.success(rateData))
                } catch {
                    callback(.failure(.cannotProcessData))
                }
            }
        }
        task?.resume()
    }
    
}
