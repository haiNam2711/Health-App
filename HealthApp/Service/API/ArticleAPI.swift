//
//  ArticleAPI.swift
//  HealthApp
//
//  Created by Hai Nam on 10/12/2023.
//
import Foundation

protocol ArticleAPIDelegate {
    func fetchDataSuccessfully(data: [Article])
    func fetchDataFailed(error: Error)
}

class ArticleAPI {
    var url: String?
    var delegate: ArticleAPIDelegate?
    
    func fetchData() {
        guard let url else {
            return
        }
        APIService.shared.fetchData(url) { (result: Result<ArticleResponse, Error>) in
            switch result {
            case .success(let response):
                self.delegate?.fetchDataSuccessfully(data: response.data.items)
            case .failure(let error):
                self.delegate?.fetchDataFailed(error: error)
            }
        }
    }
}

