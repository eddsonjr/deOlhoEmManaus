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
    @IBOutlet weak var resultsCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //conformando o delegate e o datasource de ambas as collections
    
        self.resultsCollectionView.dataSource = self
        self.resultsCollectionView.delegate = self
        
        //conformando a searchbar
        self.searchBar.delegate = self
        self.searchBar.showsCancelButton = true
        self.searchBar.isUserInteractionEnabled = false
               
        print(TAG + "Shows filtrados do modelSingleton: \(ModelSingleton.shared.showsFiltered.count)")
        
        
        
    }
    
    
    //-----------------------------------------------------
    //CollectionView functions
    //-----------------------------------------------------
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        return ModelSingleton.shared.showsFiltered.count
    
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = resultsCollectionView.dequeueReusableCell(withReuseIdentifier: "resultsCollectionViewCell", for: indexPath) as! CollectionViewCell
        
        
        var imgUrl = ""
        var address = ""
        
        imgUrl = ModelSingleton.shared.showsFiltered [indexPath.row].imageUrl!
        address = (ModelSingleton.shared.showsFiltered[indexPath.row].showHouse?.name!)!
        print(TAG + "\(indexPath.row)")

        cell.textView.text = address
        cell.imageView.loadImageUsingCache(withUrl: imgUrl)
        
        
        return cell
        
        
    }
    
    

}
