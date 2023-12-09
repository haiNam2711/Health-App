//
//  APIService.swift
//  HealthApp
//
//  Created by Hai Nam on 08/12/2023.
//

import Foundation
import Alamofire

class APIService {
    static let shared = APIService()

    func fetchData<T: Decodable>(_ url: String, completion: @escaping (Result<T, Error>) -> Void) {
        AF.request(url, parameters: nil)
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}


