//
//  Fetch.swift
//  Baluchon
//
//  Created by fred on 04/01/2022.
//

import Foundation

final class APIService {

    static var shared = APIService()
        private init() {}

    private  var task: URLSessionDataTask?
    private var session = URLSession(configuration: .default)
    init(session: URLSession) {
        self.session = session
    }

    typealias _result<T: Decodable> = (Result<T, FetchError>) -> Void

    func getData<T: Decodable>(
        request: URL,
        dataType: T.Type,
        completion: @escaping (_result<T>)
    ) {

        task = session.dataTask(with: request) { (data, urlResponse, error) in
            DispatchQueue.main.async {

                if let error = error {
                    completion(.failure(.connexion(error)))
                }
                guard let urlResponse = urlResponse as? HTTPURLResponse else {
                    completion(.failure(.unknow))
                    return
                }
                guard let data = data else { return }
                switch urlResponse.statusCode {
                case 200..<300:
                    do {
                        let dataload = try JSONDecoder().decode(dataType, from: data)
                        #if DEBUG
                        print(dataload)
                        #endif
                        completion(.success(dataload))
                        }
                    catch {
                        completion(.failure(.invalidData))
                    }
                default:
                    completion(.failure(.response(urlResponse.statusCode)))
                }
            }
        }
        task?.resume()
    }
}

extension APIService {
    enum FetchError: LocalizedError {
        case response(Int)
        case invalidData
        case connexion(Error)
        case unknow

        var errorDescription: String? {
            switch self {
            case .response(let error):
                return "Donnée non trouvée, erreur \(error).\n\n Vérifier la langue ou l'orthographe.\n Exemple pour Pointe à Pitre,\n saisir pointe-a-pitre"
            case .invalidData:
                return "Les données reçues ne sont pas conformes"
            case .unknow:
                return "Une erreur est survenue"
            case .connexion(_):
                return "La connexion Internet semble être hors ligne."
            }
        }
    }
}
