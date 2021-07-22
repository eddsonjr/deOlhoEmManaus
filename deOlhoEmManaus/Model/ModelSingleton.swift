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
    var showsFiltered: [Show] = [] //armazena a lista de shows que e filtrada de acordo com a data
    var searching: Bool = false
    
    
    
    
    
    //Este metodo serve para organizar os dados que foram baixados da internet (via firebase)
    func organizeCategoryAndShowData() {
        for categorie in self.categories {
            print(self.TAG + "Organizing shows of category \(categorie.name)")
            for show in self.shows {
                if(show.category == categorie.name){
                    print(self.TAG + "Putting show \(show.id) in category \(categorie.name)")
                    categorie.shows.append(show)
                }
            }
        }
    }
    
    
    
    //esta funcao serve para organizar os shows
    func postDataOrganize() {
        organizeCategoryAndShowData() //organizar os shows dentro das categorias
        removeCategoriesWithNoShows() //remove as categorias sem shows
        
        
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
    
    
}
