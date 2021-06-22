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
