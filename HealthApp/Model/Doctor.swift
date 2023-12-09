//
//  Doctor.swift
//  HealthApp
//
//  Created by Hai Nam on 08/12/2023.
//

import Foundation

struct Doctor: Decodable {
    let full_name: String
    let avatar: String
    let majors_name: String
    let ratio_star: Double
    let number_of_stars: Int
}
