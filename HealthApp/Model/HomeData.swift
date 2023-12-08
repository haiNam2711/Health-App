//
//  HomeData.swift
//  HealthApp
//
//  Created by Hai Nam on 08/12/2023.
//

import Foundation

struct HomeResponse: Decodable {
    let status: Int
    let message: String
    let code: Int
    let data: HomeData
}

struct HomeData: Decodable {
    let articleList: [Article]
    let promotionList: [Promotion]
    let doctorList: [Doctor]
}
