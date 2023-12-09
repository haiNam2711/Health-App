//
//  GetFont.swift
//  HealthApp
//
//  Created by Hai Nam on 01/12/2023.
//

import UIKit

struct GetFont {
    
    static func nunitoBold(_ size: CGFloat) -> UIFont? {
        return UIFont(name: K.Font.NunitoBold, size: size)
    }
    static func nunitoRegular(_ size: CGFloat) -> UIFont? {
        return UIFont(name: K.Font.NunitoRegular, size: size)
    }
    static func nunitoSemiBold(_ size: CGFloat) -> UIFont? {
        return UIFont(name: K.Font.NunitoSemiBold, size: size)
    }
}

