//
//  ConvertRepository.swift
//  Baluchon
//
//  Created by fred on 21/01/2022.
//

import Foundation

typealias RateOrError = (_ rateData: (Rate)?, _ error: Error?) -> Void

class ConvertRepository {

    /// Retrieving the result of the network call (Rate data or error) with the APIService method call

    static var shared = ConvertRepository()
    private init() {}

    var apiKey = (Bundle.main.infoDictionary?["CONVERT_API_KEY"] as? String).orEmpty

    /// to test getUrl method with a fake apiKey
    init(apiKey: String) {
        self.apiKey = apiKey
    }

    func getRate(completion: @escaping RateOrError) {

        guard let url = getUrl else { return }
        APIService.shared.getData(
            request: url,
            dataType: Rate.self
        ) { result in
            switch result {
            case .failure(let error) :
                completion(nil, error)
            case.success(let rateData) :
                completion(rateData, nil)
            }
        }
    }
}

extension ConvertRepository {
    /// build url
    var getUrl: URL? {
        var component = URLComponents()
        component.scheme = "https"
        component.host = "api.apilayer.com"
        component.path = "/fixer/latest"
        component.queryItems = [URLQueryItem(name: "symbols", value: "USD")]
        component.queryItems = [URLQueryItem(name: "base", value: "EUR")]
        component.queryItems = [URLQueryItem(name: "apikey", value: "\(apiKey)")]
        return component.url
    }
}
