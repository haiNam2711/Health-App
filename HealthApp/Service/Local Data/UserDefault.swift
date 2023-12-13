//
//  UserDefault.swift
//  HealthApp
//
//  Created by Hai Nam on 12/12/2023.
//

import Foundation
struct UserDefault {
    func saveUser(_ user: User) {
        let userDefaults = UserDefaults.standard
        
        userDefaults.set(user.name, forKey: "name")
        userDefaults.set(user.last_name, forKey: "lastName")
        userDefaults.set(user.birth_date, forKey: "birthDate")
        userDefaults.set(user.sex == 1 ? true : false, forKey: "genderMan")
        userDefaults.set(user.phone, forKey: "phoneNum")
        userDefaults.set(user.contact_email, forKey: "email")
        userDefaults.set(user.address, forKey: "address")

        userDefaults.synchronize()
    }
    
    func loadUser() -> User?{
        let userDefaults = UserDefaults.standard
        if let _ = userDefaults.string(forKey: "name") {
            let last_name = userDefaults.string(forKey: "lastName")!
            let name = userDefaults.string(forKey: "name")!
            let birth_date = userDefaults.string(forKey: "birthDate")!
            let sex = userDefaults.bool(forKey: "genderMan") == true ? 1 : 0
            let phone = userDefaults.string(forKey: "phoneNum")!
            let contact_email = userDefaults.string(forKey: "email")!
            let address = userDefaults.string(forKey: "address")!
            let province_code = "Thành phố Hồ Chí Minh"
            let district_code = "Quận 9"
            let ward_code = "Phường Phú Hữu"
            let blood_name = "O+"
            return User(last_name: last_name, name: name, birth_date: birth_date, sex: sex, phone: phone, contact_email: contact_email, province_code: province_code, district_code: district_code, ward_code: ward_code, address: address, blood_name: blood_name, avatar: "")
        }
        return nil
    }
}
