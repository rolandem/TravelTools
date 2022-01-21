//
//  ConvertRepository.swift
//  Baluchon
//
//  Created by fred on 21/01/2022.
//

import Foundation

class ConvertRepository {

    typealias RateOrError = (_ rateData: (RateData)?, _ error: Error?) -> Void

    static var shared = ConvertRepository()
    private init() {}

    var apiKey = (Bundle.main.infoDictionary?["CONVERT_API_KEY"] as? String).orEmpty

    init(apiKey: String) {
        self.apiKey = apiKey
    }

    func getRate(completion: @escaping RateOrError) {

        guard let url = getUrl else { return }
        APIService.shared.getData(
            request: url,
            dataType: RateData.self
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

    var getUrl: URL? {
        var component = URLComponents()
        component.scheme = "http"
        component.host = "data.fixer.io"
        component.path = "/api/latest"
        component.queryItems = [URLQueryItem(name: "access_key", value: "\(apiKey)")]
        return component.url
    }
}
