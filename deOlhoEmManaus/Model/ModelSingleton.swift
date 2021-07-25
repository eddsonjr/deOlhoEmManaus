//
//  ShowSingleton.swift
//  VitrineProdutos
//
//  Created by Edson  Jr on 10/01/2020.
//  Copyright © 2020 Edson  Jr. All rights reserved.
//
//  Este singleton serve para controlar e armazenar informacoes que sao distribuidas
//  em conjunto com as demais classes do aplicativo.
//  Sao armazenados informacoes com relacao a lista de categorias, shows e selecoes do usuario
//
//
import Foundation

class ModelSingleton {

    private let TAG = "[ModelSingleton]: "
    static let shared = ModelSingleton()
    var showSelected: Show? //armazena informacao do show selecionado pelo usuario na tela principal
    var shows: [Show] = [] //armazena a lista de shows baixadas da internet (via firebase)
    var categories: [Categorie] = [] //armazena a lista de categorias baixadas da internet (via firebase)
    var showsFiltered: [Show] = [] 
    var searching: Bool = false
    
    
    
   
    
    
    
    //esta funcao serve para organizar os shows
    func postDataOrganize() {
    
        
        
    }
    
    
    
    //Esta funcao serve para remover categorias que nao apresentam shows associados.
    func removeCategoriesWithNoShows() {
        var tempArray: [Categorie] = []
        for categorie in self.categories {
            if(categorie.shows.count != 0){
                tempArray.append(categorie)
                print(self.TAG + "Categorie \(categorie.name) with \(categorie.shows.count) shows within...")
            }
        }
        self.categories = tempArray
        print(self.TAG + "Number of categories: \(self.categories.count) - [after remove no shows]")
    }
    
    
    
    
    
    func organizeShowsByDate(){
        
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        for category in self.categories {
            category.shows.sorted(by: {
                dateFormatter.date(from: $0.endDate!)?.compare(dateFormatter.date(from: $1.endDate!)!) == .orderedDescending
                
            })
        }
    }
    
    
}
