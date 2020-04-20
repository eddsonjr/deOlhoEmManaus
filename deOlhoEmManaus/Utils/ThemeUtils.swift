//
//  ThemeUtils.swift
//  deOlhoEmManaus
//
//  Created by Edson  Jr on 20/04/20.
//  Copyright © 2020 Edson  Jr. All rights reserved.
//

import Foundation
import UIKit




@objc open class DynamicColor : NSObject{
    public   var light :  UIColor
    public   var dark :  UIColor
    public  init(light : UIColor,dark : UIColor) {
        self.light = light
        self.dark = dark
    }
}



