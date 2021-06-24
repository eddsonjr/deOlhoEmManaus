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
    var searchActive : Bool = false
    var listaFiltrada : Array<Show>? = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //conformando o delegate e o datasource de ambas as collections
    
        self.resultsCollectionView.dataSource = self
        self.resultsCollectionView.delegate = self
        
        //conformando a searchbar
        self.searchBar.delegate = self
        self.searchBar.showsCancelButton = true
        self.searchBar.isUserInteractionEnabled = true
        self.searchBar.setImage(UIImage(), for: .clear, state: .normal)
               
        print(TAG + "Shows filtrados do modelSingleton: \(ModelSingleton.shared.showsFiltered.count)")
   
    }
    
    
    //-----------------------------------------------------
    //CollectionView functions
    //-----------------------------------------------------
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if(self.searchActive){
            return listaFiltrada!.count
        }else{
            return ModelSingleton.shared.showsFiltered.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = resultsCollectionView.dequeueReusableCell(withReuseIdentifier: "resultsCollectionViewCell", for: indexPath) as! CollectionViewCell
        
        
        var imgUrl = ""
        var address = ""
        
        if(searchActive){
            imgUrl = listaFiltrada![indexPath.row].imageUrl!
            address = (listaFiltrada![indexPath.row].showHouse?.name)!
        }else{
            imgUrl = ModelSingleton.shared.showsFiltered [indexPath.row].imageUrl!
            address = (ModelSingleton.shared.showsFiltered[indexPath.row].showHouse?.name!)!
        }
    
        cell.textView.text = address
        cell.imageView.loadImageUsingCache(withUrl: imgUrl)
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //Passando os dados de show selecionado pelo usuario para o singleton
        var show: Show = Show()
        show = ModelSingleton.shared.showsFiltered[indexPath.row]
        print(TAG + "Show selecionado: \(show.showHouse?.name)")
        ModelSingleton.shared.showSelected = show
    }
    
    
    
    //-------------------------------------------------------------------
    //Mark: Funcoes de searchbar
    //------------------------------------------------------------------
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true;
        self.listaFiltrada = ModelSingleton.shared.showsFiltered
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
        self.searchBar.endEditing(true)
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //caso a barra de busca nao tenha nenhum dado e esteja vazia, desabilitar a buscar e recarregar toda a tableview
        if(self.searchBar.text?.isEmpty)!{
            self.searchActive = false
            view.endEditing(true)
            self.resultsCollectionView.reloadData()
        }else{ //caso o usuario esteja realizando uma busca
            self.searchActive = true
            self.listaFiltrada = ModelSingleton.shared.showsFiltered.filter{
                guard let textSearch = self.searchBar.text?.lowercased() else {return false}
                return ($0.showHouse?.name!.lowercased().contains(textSearch))!
            }
            
        }
            self.resultsCollectionView.reloadData()
            
    }
    
    

}
