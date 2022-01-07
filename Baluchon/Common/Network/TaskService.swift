//
//  Fetch.swift
//  Baluchon
//
//  Created by fred on 04/01/2022.
//

import Foundation

final class TaskService {
 
    private var task: URLSessionDataTask?

    func taskData<T: Decodable>(urlSession: URLSession,
                                request: URL,
                                requestDataType: T.Type,
                                completionHandler: @escaping (Result<T, FetchError>) -> Void) {
        
        task?.cancel()
        task = urlSession.dataTask(with: request) { (data, urlResponse, error) in
            if let error = error {
                DispatchQueue.main.async {
                    completionHandler(.failure(.connexion(error)))
                }
                return
            }
            guard let urlResponse = urlResponse as? HTTPURLResponse else {
                DispatchQueue.main.async {
                    completionHandler(.failure(.unknown))
                }
                return
            }
            switch urlResponse.statusCode {
            case 200..<300:
                do {
                    let dataload = try JSONDecoder().decode(requestDataType, from: data ?? Data())
                    DispatchQueue.main.async {
                        completionHandler(.success(dataload))
                    }
                }
                catch let jsonError {
                    DispatchQueue.main.async {
                        completionHandler(.failure(.invalidData(jsonError)))
                    }
                }
            default:
                DispatchQueue.main.async {
                    completionHandler(.failure(.response(urlResponse.statusCode)))
                }
            }
        }
        task?.resume()
    }
}
extension TaskService {
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
