//
//  UserAPI.swift
//  HealthApp
//
//  Created by Hai Nam on 11/12/2023.
//

import Foundation

protocol UserAPIDelegate {
    func fetchDataSuccessfully(data: User)
    func fetchDataFailed(error: Error)
}

class UserAPI {
    var url: String?
    var delegate: UserAPIDelegate?
    
    func fetchData() {
        guard let url else {
            return
        }
        APIService.shared.fetchData(url) { (result: Result<UserResponse, Error>) in
            switch result {
            case .success(let response):
                self.delegate?.fetchDataSuccessfully(data: response.data)
            case .failure(let error):
                self.delegate?.fetchDataFailed(error: error)
            }
        }
    }
}
