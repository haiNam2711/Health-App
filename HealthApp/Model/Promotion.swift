//
//  Promotion.swift
//  HealthApp
//
//  Created by Hai Nam on 08/12/2023.
//

import Foundation

struct Promotion: Decodable {
    let name: String
    let picture: String
    let created_at: String
    let category_name: String
    let is_bookmark: Bool
}
