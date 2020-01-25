//
//  Categoria.swift
//  VitrineProdutos
//
//  Created by Edson  Jr on 30/10/2019.
//  Copyright © 2019 Edson  Jr. All rights reserved.
//

import Foundation
import UIKit

class Categorie{
    
    var name: String?
    var shows: [Show]?
    
    
    //default init - sem parametros
    init() {}
    
    
    //init com parametros
    init(name: String?,shows:[Show]?){
        self.name = name
        self.shows = shows
    }

}



