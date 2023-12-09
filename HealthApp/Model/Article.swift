//
//  News.swift
//  HealthApp
//
//  Created by Hai Nam on 08/12/2023.
//

import Foundation

struct Article: Decodable {
    let title: String
    let picture: String
    let created_at: String
    let category_name: String
}
