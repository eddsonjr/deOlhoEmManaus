//
//  SearchViewController.swift
//  deOlhoEmManaus
//
//  Created by Edson  Jr on 21/06/21.
//  Copyright © 2021 Edson  Jr. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UICollectionViewDataSource,UICollectionViewDelegate, UISearchBarDelegate{
    
    private let TAG = "[SearchViewController]:"
    
    //Elementos visuais na viewController
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var categoryNamesCollectionView: UICollectionView!
    @IBOutlet weak var resultsCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //conformando o delegate e o datasource de ambas as collections
        self.categoryNamesCollectionView.dataSource = self
        self.categoryNamesCollectionView.delegate = self
        self.resultsCollectionView.dataSource = self
        self.resultsCollectionView.delegate = self
        
        //conformando a searchbar
        self.searchBar.delegate = self
        self.searchBar.showsCancelButton = true
        self.searchBar.isUserInteractionEnabled = false
        
        //somente para testes
        print(TAG + "Categorias do modelSingleton: \(ModelSingleton.shared.categories.count)")
        
        print(TAG + "Shows do modelSingleton: \(ModelSingleton.shared.shows.count)")
        
        
        
    }
    
    
    //-----------------------------------------------------
    //CollectionView functions
    //-----------------------------------------------------
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == categoryNamesCollectionView {
            return ModelSingleton.shared.categories.count
        }else {
            return ModelSingleton.shared.shows.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell: UICollectionViewCell? = nil
        
        if collectionView == categoryNamesCollectionView {
            cell = categoryNamesCollectionView.dequeueReusableCell(withReuseIdentifier: "categoryNamesCollectionCell", for: indexPath) as! CategoriesNamesSearchCollectionViewCell
            
            //TODO - TERMINAR A IMPLEMENTACAO AQUI
            
        }else {
            cell = resultsCollectionView.dequeueReusableCell(withReuseIdentifier: "resultsCollectionViewCell", for: indexPath)
            
            
            //TODO - TERMINAR A IMPLEMENTACAO AQUI
        }
        
        return cell!
        
    }
    
    

}
