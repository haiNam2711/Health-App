//
//  HomeAPI.swift
//  HealthApp
//
//  Created by Hai Nam on 08/12/2023.
//

import Foundation

protocol HomeApiDelegate {
    func fetchDataSuccessfully(data: HomeData)
    func fetchDataFailed(error: Error)
}

class HomeAPI {
    var url : String?
    var delegate: HomeApiDelegate?
    
    func fetchData() {
        guard let url else {
            return
        }
        APIService.shared.fetchData(url) { (result: Result<HomeResponse, Error>) in
            switch result {
            case .success(let homeResponse):
                self.delegate?.fetchDataSuccessfully(data: homeResponse.data)
            case .failure(let error):
                self.delegate?.fetchDataFailed(error: error)
            }
        }
    }
}
