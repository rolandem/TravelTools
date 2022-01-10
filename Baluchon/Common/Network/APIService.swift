//
//  Fetch.swift
//  Baluchon
//
//  Created by fred on 04/01/2022.
//

import Foundation

final class APIService {

    typealias result<T: Decodable> = (Result<T, FetchError>) -> Void

    static func getData<T: Decodable>(
        request: URL,
        dataType: T.Type,
        completion: @escaping (result<T>)
    ) {

        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { (data, urlResponse, error) in
            DispatchQueue.main.async {
                
                if let error = error {
                    completion(.failure(.connexion(error)))
                }
                guard let urlResponse = urlResponse as? HTTPURLResponse else {
                    completion(.failure(.unknown))
                    return
                }
                switch urlResponse.statusCode {
                case 200..<300:
                    do {
                        let dataload = try JSONDecoder().decode(dataType, from: data ?? Data())
                        completion(.success(dataload))
                    }
                    catch let jsonError {
                        completion(.failure(.invalidData(jsonError)))
                    }
                default:
                    completion(.failure(.response(urlResponse.statusCode)))
                }
            }
        }
        task.resume()
    }
}

extension APIService {
    enum FetchError: LocalizedError {
        case response(Int)
        case invalidData(Error)
        case connexion(Error)
        case unknown
        case wrongUrl
        
        var errorDescription: String? {
            switch self {
            case .response(let error):
                return "Une erreur \(error) serveur est survenue"
            case .invalidData(_):
                return "Les données reçues ne sont pas conformes"
            case .connexion(_):
                return "La connexion Internet semble être hors ligne."
            case .unknown:
                return "Une erreur inconnue est survenue"
            case .wrongUrl:
                return "erreur (404)"
            }
        }
    }
}
