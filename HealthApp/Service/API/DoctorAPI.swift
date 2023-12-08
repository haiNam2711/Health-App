//
//  DoctorAPI.swift
//  HealthApp
//
//  Created by Hai Nam on 08/12/2023.
//

import Foundation

protocol DoctorAPIDelegate {
    func fetchDataSuccessfully(data: [Doctor])
    func fetchDataFailed(error: Error)
}

class DoctorAPI {
    var url : String?
    var delegate: DoctorAPIDelegate?
    
    func fetchData() {
        guard let url else {
            return
        }
        APIService.shared.fetchData(url) { (result: Result<DoctorResponse, Error>) in
            switch result {
            case .success(let response):
                print(response.data.items.count)
                self.delegate?.fetchDataSuccessfully(data: response.data.items)
            case .failure(let error):
                print(error.localizedDescription)
                self.delegate?.fetchDataFailed(error: error)
            }
        }
    }
}
