//
//  ShowHouse.swift
//  VitrineProdutos
//
//  Created by Edson  Jr on 11/11/2019.
//  Copyright © 2019 Edson  Jr. All rights reserved.
//

import Foundation


class ShowHouse {
    
    var id: String?
    var name: String?
    var street: String?
    var number: String?
    var city: String?
    var neighborhood: String?
    var zip: String?
    var completAddress: String?
    var phones: [String]?
    
    
    
    //default init
    init() {}
    
    
    
    init(id: String?, name: String?,street: String?, number: String?, city: String, neighborhood: String?, zip: String?, completeAdrress: String?, phones: [String]?) {
        self.id = id
        self.name = name
        self.street = street
        self.number = number
        self.city = city
        self.neighborhood = neighborhood
        self.zip = zip
        self.completAddress = completeAdrress
        self.phones = phones
        
    }
    
}
