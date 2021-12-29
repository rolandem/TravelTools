//
//  ConvertRequest.swift
//  Baluchon
//
//  Created by fred on 29/12/2021.
//

import Foundation

class QueryService {

    static var shared = QueryService()
    private init()
    {}

    private static let rateUrl = ConvertAPI.convertUrl

    static func getRate(callback: @escaping(Result<ExchangeRate, RateError>) -> Void) {

print("url =", rateUrl as Any)
        
        guard let rateUrl = rateUrl else {
            print(RateError.wrongUrl)
            return }
        
        URLSession.shared.dataTask(with: rateUrl) { (data, response, error) in
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
        } .resume()
    }
    
}
