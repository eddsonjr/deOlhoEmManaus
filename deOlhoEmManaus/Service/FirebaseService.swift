//
//  Firebase.swift
//  deOlhoEmManaus
//
//  Created by Edson  Jr on 24/01/2020.
//  Copyright © 2020 Edson  Jr. All rights reserved.
//

import Foundation
import Firebase
import UIKit


class FirebaseService {
    
    
    private let TAG = "[FirebaseDAO]: "
    private let retrieveAllCategoriesDispatchGroup = DispatchGroup()
    private let retrieveAllShowsDispatchGroup = DispatchGroup()
    private let organizingDataDispatchGroup = DispatchGroup()
    private let appDelegateReference = UIApplication.shared.delegate as! AppDelegate
    private let notificationIdentifier: String = "NotificationIdentifier"
    
    
    //Funcao para baixar todos os dados de categoria
    func retrieveDataFromWeb() {
        let ref = appDelegateReference.databaseRef
        self.retrieveAllCategoriesDispatchGroup.enter()
        ref?.child("category/-LrarCqAGUtS3LqUFg1S/listCategory").observeSingleEvent(of: .value, with: { snapshot in
            if !snapshot.exists() {
                print(self.TAG  + "ERROR: Data not found or cannot download")
                return }
            
//            let jsonFromFirebase = snapshot.value!
//            print(self.TAG)
//            print(jsonFromFirebase)
            
            for categoria in snapshot.children.allObjects as! [DataSnapshot] {
                var categoriaModel: Categorie = Categorie()
                categoriaModel.name = categoria.value as? String
                ModelSingleton.shared.categories.append(categoriaModel)
            }
            self.retrieveAllCategoriesDispatchGroup.leave()
        })
        
        self.retrieveAllCategoriesDispatchGroup.notify(queue: .main) {
            print(self.TAG + "Number of categories downloaded: \(ModelSingleton.shared.categories.count)")
            self.retrieveListOfShowsData()
            
            
        }
    }
    
    
    
    
    
    
    //funcao para baixar todos os dados de shows
    func retrieveListOfShowsData() {
        let ref = appDelegateReference.databaseRef
        self.retrieveAllShowsDispatchGroup.enter()
        ref?.child("show").observeSingleEvent(of: .value, with: { snapshot in
            
//            if !snapshot.exists() {
//                print(self.TAG  + "ERROR: Data not found or cannot download")
//                return }
            
//            let jsonFromFirebase = snapshot.value!
//            print(self.TAG)
//            print(jsonFromFirebase)
            
            for show in snapshot.children.allObjects as! [DataSnapshot] {
                let dict = show.value as? [String:Any]
                /*
                 Este codigo serve tanto para baixar as informacoes de shows quanto as informacoes de showHouse que estao
                 abribuidas a eles
                 */
                
                var showModel: Show = Show() //mantem informacoes de show
                var showHouseModel: ShowHouse = ShowHouse() //mantem as informacoes de showHouse [estas vao para dentro de show]
                
                //baixando as informacoes de show e fazendo parser
                showModel.id = dict!["id"] as? String
                showModel.category = dict!["category"] as? String
                showModel.subCategory = dict!["subCategory"] as? String
                showModel.imageUrl = dict!["imageUrl"] as? String
                showModel.hasDate = dict!["hasDate"] as? Bool
                showModel.endDate = dict!["endDate"] as? String
                showModel.startDate = dict!["startDate"] as? String
                
                
                //baixando as informacoes de showHouse e address e fazendo parser
                let showHouseDict = dict!["showHouse"] as? [String:Any]
                let addressDict = showHouseDict!["address"] as? [String:Any]
                showHouseModel.name = showHouseDict!["name"] as? String
                showHouseModel.city = addressDict!["city"] as? String
                showHouseModel.neighborhood = addressDict!["neighborhood"] as? String
                showHouseModel.street = addressDict!["street"] as? String
                showHouseModel.number = addressDict!["number"] as? String
                showHouseModel.completAddress = addressDict!["completeAddress"] as? String
                showHouseModel.phones = dict!["phones"] as? [String]

                
                //Colocando showHouse dentro de Show
                showModel.showHouse = showHouseModel
                
                ModelSingleton.shared.shows.append(showModel)
            }
            self.retrieveAllShowsDispatchGroup.leave()
        })
        
        self.retrieveAllShowsDispatchGroup.notify(queue: .main) {
            print(self.TAG + "Number of shows downloaded: \(ModelSingleton.shared.shows.count) ")
            self.organizeAllCategoriesAndShowData()
        }
    }
    
    
    
    
    
    //Esta funcao serve para organizar os dados de acordo com
    func organizeAllCategoriesAndShowData() {
        self.organizingDataDispatchGroup.enter()
        for categorie in ModelSingleton.shared.categories {
            print(self.TAG + "Organizing shows of category \(categorie.name)")
            for show in ModelSingleton.shared.shows {
                if(show.subCategory == categorie.name){
                    
                    //verificando tambem agora a data
                    if(!DateUtils.checkDateToRemoveBanner(dateFromServer: show.endDate)){
                        print(self.TAG + "Putting show \(show.id) in category \(categorie.name)")
                        categorie.shows.append(show)
                    }
                }
            }
        }
        
        ModelSingleton.shared.removeCategoriesWithNoShows()
        
        self.organizingDataDispatchGroup.leave()
        self.organizingDataDispatchGroup.notify(queue: .main) {
            NotificationCenter.default.post(name: Notification.Name("NotificationIdentifier"), object: nil)
        }
        
    }
    
}
