//
//  PromoAPI.swift
//  HealthApp
//
//  Created by Hai Nam on 08/12/2023.
//

import Foundation

protocol PromoAPIDelegate {
    func fetchDataSuccessfully(data: [Promotion])
    func fetchDataFailed(error: Error)
}

class PromoAPI {
    var url : String?
    var delegate: PromoAPIDelegate?
    
    func fetchData() {
        guard let url else {
            return
        }
        APIService.shared.fetchData(url) { (result: Result<PromoResponse, Error>) in
            switch result {
            case .success(let response):
                self.delegate?.fetchDataSuccessfully(data: response.data.items)
            case .failure(let error):
                self.delegate?.fetchDataFailed(error: error)
            }
        }
    }
}
