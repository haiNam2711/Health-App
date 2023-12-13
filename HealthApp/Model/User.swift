//
//  User.swift
//  HealthApp
//
//  Created by Hai Nam on 11/12/2023.
//

import Foundation

struct User: Decodable {
    let last_name: String
    let name: String
    let birth_date: String
    let sex: Int
    let phone: String
    let contact_email: String
    let province_code: String
    let district_code: String
    let ward_code: String
    let address: String
    let blood_name: String
    let avatar: String
}
