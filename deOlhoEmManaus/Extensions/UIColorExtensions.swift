//
//  UIColorExtensions.swift
//  deOlhoEmManaus
//
//  Created by Edson  Jr on 20/04/20.
//  Copyright © 2020 Edson  Jr. All rights reserved.
//

import Foundation
import UIKit



extension UIColor{
   class func DynamicResolved(color: DynamicColor) -> UIColor{
    if #available(iOS 13.0, *) {
        let dynamicColor = UIColor { (traitCollection: UITraitCollection) -> UIColor in
            if traitCollection.userInterfaceStyle == .dark {
                return color.dark
            } else {
                return color.light
            }
        }
        return dynamicColor
    } else {
        // Fallback on earlier versions
        return color.light
    }
    }

}
