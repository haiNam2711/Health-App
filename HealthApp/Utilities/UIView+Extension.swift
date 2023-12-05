//
//  UIView+Extension.swift
//  HealthApp
//
//  Created by Hai Nam on 04/12/2023.
//

import UIKit

extension UIView {

    var x: CGFloat {
        get {
            self.frame.origin.x
        }
        set {
            print(newValue)
            print(self.frame.origin.x)
            self.frame.origin.x = newValue
        }
    }

    var y: CGFloat {
        get {
            self.frame.origin.y
        }
        set {
            print(newValue)
            print(self.frame.origin.x)
            self.frame.origin.y = newValue
        }
    }

    var height: CGFloat {
        get {
            self.frame.size.height
        }
        set {
            self.frame.size.height = newValue
        }
    }

    var width: CGFloat {
        get {
            self.frame.size.width
        }
        set {
            self.frame.size.width = newValue
        }
    }
}

