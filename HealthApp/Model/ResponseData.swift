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

struct DoctorResponse: Decodable {
    let status: Int
    let message: String
    let code: Int
    let data: DoctorItem
}

struct DoctorItem: Decodable {
    let items: [Doctor]
}


struct PromoResponse: Decodable {
    let status: Int
    let message: String
    let code: Int
    let data: PromoItem
}

struct PromoItem: Decodable {
    let items: [Promotion]
}

struct DetailResponse: Decodable {
    let status: Int
    let message: String
    let code: Int
    let data: PromotionDetail
}

struct PromotionDetail: Decodable {
    let name: String
    let content: String
    let picture: String
    let created_at: String
    let link: String
}

struct ArticleResponse: Decodable {
    let status: Int
    let message: String
    let code: Int
    let data: ArticleItem
}

struct ArticleItem: Decodable {
    let items: [Article]
}

struct UserResponse: Decodable {
    let status: Int
    let message: String
    let code: Int
    let data: User
}
