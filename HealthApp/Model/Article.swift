//
//  News.swift
//  HealthApp
//
//  Created by Hai Nam on 08/12/2023.
//

import Foundation

struct Article: Decodable {
    let id: Int
    let category_id: Int
    let title: String
    let slug: String
    let picture: String
    let picture_caption: String
    let created_at: String
    let category_name: String
    let link: String
}
