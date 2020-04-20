//
//  ThemeExtensions.swift
//  deOlhoEmManaus
//
//  Created by Edson  Jr on 20/04/20.
//  Copyright © 2020 Edson  Jr. All rights reserved.
//

import Foundation
import UIKit


extension DynamicColor{
  public  func resolve() -> UIColor{
       return UIColor.DynamicResolved(color: self)
    
    }
}
