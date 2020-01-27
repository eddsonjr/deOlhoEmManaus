//
//  InteratorExtension.swift
//  deOlhoEmManaus
//
//  Created by Edson  Jr on 27/01/2020.
//  Copyright © 2020 Edson  Jr. All rights reserved.
//

import Foundation

extension Collection where Indices.Iterator.Element == Index {
    subscript (exist index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
