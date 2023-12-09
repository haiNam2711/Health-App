//
//  DetailAPI.swift
//  HealthApp
//
//  Created by Hai Nam on 09/12/2023.
//

import Foundation

protocol DetailAPIDelegate {
    func fetchDataSuccessfully(data: PromotionDetail)
    func fetchDataFailed(error: Error)
}

class DetailAPI {
    var url: String?
    var delegate: DetailAPIDelegate?
    
    func fetchData() {
        guard let url else {
            return
        }
        APIService.shared.fetchData(url) { (result: Result<DetailResponse, Error>) in
            switch result {
            case .success(let response):
                self.delegate?.fetchDataSuccessfully(data: response.data)
            case .failure(let error):
                self.delegate?.fetchDataFailed(error: error)
            }
        }
    }
}

