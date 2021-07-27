//
//  SearchViewController.swift
//  deOlhoEmManaus
//
//  Created by Edson  Jr on 21/06/21.
//  Copyright © 2021 Edson  Jr. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UICollectionViewDataSource,UICollectionViewDelegate, UISearchBarDelegate,ReachabilityObserverDelegate{
    
    private let TAG = "[SearchViewController]:"
    
    //Elementos visuais na viewController
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var resultsCollectionView: UICollectionView!
    var searchActivated: Bool = false
    var listaFiltrada : Array<Show>? = []
    
    @IBOutlet weak var noWebView: UIView!
    
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
        
        
        try? addReachabilityObserver() //habilitando sistema para verificar se ha ou nao conexao com web
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.resultsCollectionView.reloadData()
        print(TAG + "Shows filtrados do modelSingleton: \(ModelSingleton.shared.showsFiltered.count)")
        print(TAG + "Searching: \(searchActivated)")
        self.searchBar.text = ""
        self.searchBar.becomeFirstResponder()
        
    }
    
    
    //-----------------------------------------------------
    //CollectionView functions
    //-----------------------------------------------------
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if(searchActivated){
            return listaFiltrada!.count
        }else{
            return ModelSingleton.shared.showsFiltered.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = resultsCollectionView.dequeueReusableCell(withReuseIdentifier: "resultsCollectionViewCell", for: indexPath) as! CollectionViewCell
        
        
        var imgUrl = ""
        var address = ""
        
        if(searchActivated){
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
        ModelSingleton.shared.showSelected = nil
        if(searchActivated){
            var show = Show()
            show = listaFiltrada![indexPath.row]
            print(TAG + "Show Selecionado - Busca: \(show.showHouse?.name)")
            print(TAG + "ID: \(show.id)")
            print(TAG + "IMG: \(show.imageUrl)")
            ModelSingleton.shared.showSelected = show
        }else{
            var show = Show()
            show = ModelSingleton.shared.showsFiltered[indexPath.row]
            print(TAG + "Show selecionado: \(show.showHouse?.name)")
            print(TAG + "ID: \(show.id)")
            ModelSingleton.shared.showSelected = show
        }
        
        
        
        
    }
    
    
    
    //-------------------------------------------------------------------
    //Mark: Funcoes de searchbar
    //------------------------------------------------------------------
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActivated = true;
        self.listaFiltrada = ModelSingleton.shared.showsFiltered
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActivated = false;
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActivated = false;
        self.searchBar.endEditing(true)
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActivated = false;
    }
    

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //caso a barra de busca nao tenha nenhum dado e esteja vazia, desabilitar a buscar e recarregar toda a tableview
        if(self.searchBar.text?.isEmpty)!{
            searchActivated = false
            view.endEditing(true)
            self.resultsCollectionView.reloadData()
        }else{ //caso o usuario esteja realizando uma busca
            searchActivated = true
            self.listaFiltrada = ModelSingleton.shared.showsFiltered.filter{
                guard let textSearch = self.searchBar.text?.lowercased() else {return false}
                return ($0.showHouse?.name!.lowercased().contains(textSearch))!
            }
            
        }
            print(TAG + "Qt filtrada: \(listaFiltrada?.count)")
            self.resultsCollectionView.reloadData()
            
    }
    
    
    
    //Mark: Reachability protocol
    func reachabilityChanged(_ isReachable: Bool) {
        if isReachable {
            //conectado
            self.noWebView.isHidden = true
        
            
            
        }else{
            //desconectado
            print(TAG + "web not available. Prevent download....")
            self.noWebView.isHidden = false
            AlertUtils.shared.webNotAvailableAlert(view: self)
            
        }
    }
    
    
    deinit {
       removeReachabilityObserver()
       
    }
    
    
    
    
    
    
    

}
