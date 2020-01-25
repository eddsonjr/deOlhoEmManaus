//
//  Show.swift
//  VitrineProdutos
//
//  Created by Edson  Jr on 11/11/2019.
//  Copyright © 2019 Edson  Jr. All rights reserved.
//

import Foundation


class Show {
    
    var id: String?
    var imageUrl: String?
    var hasDate: Bool?
    var endDate: String?
    var showHouse: ShowHouse?
    var showHouseKey: String?
    var category: String?
    var subCategory: String?
    
    
    //default init
    init() {}
    
    
    //init with parameters
    init(imageUrl: String?, hasDate: Bool?, endDate: String?, showHouse: ShowHouse?,category: String?, id: String, subCategory: String?){
        self.imageUrl = imageUrl
        self.endDate = endDate
        self.showHouse = showHouse
        self.category = category
        self.id = id
        self.hasDate = hasDate
        self.subCategory = subCategory
    }
    
    
}
