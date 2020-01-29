//
//  ViewController.swift
//  deOlhoEmManaus
//
//  Created by Edson  Jr on 24/01/2020.
//  Copyright © 2020 Edson  Jr. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UICollectionViewDataSource,UICollectionViewDelegate, UISearchBarDelegate {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    
    
    
    private let TAG = "[ViewController]: "
    var service: FirebaseService = FirebaseService()
    var listaDeCategorias: Array<Categorie>? = []
    var searchActive : Bool = false
    var listaFiltrada: Array<Categorie>? = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.searchBar.delegate = self
        
        
        
        // Register to receive notification
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name("NotificationIdentifier"), object: nil)
        
        
        self.service.retrieveDataFromWeb()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    //MARK: tableview datasource and delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  1
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableviewCell", for: indexPath) as! TableViewCell
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let tableViewCell = cell as? TableViewCell else { return }
        tableViewCell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.section)
        
       
    }
    
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let tableViewCell = cell as? TableViewCell else { return }
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 256
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.listaDeCategorias!.count
    }
    
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        var sectionName: String?
        if(self.searchActive){
            sectionName = self.listaFiltrada![section].name!
        }else{
            sectionName = self.listaDeCategorias![section].name!
        }
        
        return sectionName
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
    
    //MARK: collectionView datasource and delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        
        var numberOfShowsForThisCategorie  = 0
        if(self.searchActive){
            numberOfShowsForThisCategorie = self.listaFiltrada![collectionView.tag].shows.count
        }else{
            numberOfShowsForThisCategorie = self.listaDeCategorias![collectionView.tag].shows.count
        }
        
        return numberOfShowsForThisCategorie
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! CollectionViewCell
        
        var imgUrl = ""
        if(self.searchActive){
            imgUrl = self.listaFiltrada![collectionView.tag].shows[indexPath.row].imageUrl!
        }else{
            imgUrl = self.listaDeCategorias![collectionView.tag].shows[indexPath.row].imageUrl!
        }
    
        cell.imageView.loadImageUsingCache(withUrlString: imgUrl)
        return cell
    }
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //Passando os dados de show para o singleton
        var show: Show = Show()
        show = self.listaDeCategorias![collectionView.tag].shows[indexPath.row]
        ModelSingleton.shared.showSelected = show
        
    }
    
    
    
    //Mark: Funcoes de searchbar
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true;
        print(self.TAG + "User using searchbar...")
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //caso a barra de busca nao tenha nenhum dado e esteja vazia, desabilitar a buscar e recarregar toda a tableview
        if(self.searchBar.text?.isEmpty)!{
            print("AQUI CARALHO")
            self.searchActive = false
            view.endEditing(true)
            self.tableView.reloadData()
        }else{ //caso o usuario esteja realizando uma busca
            print("AQUI BUCETA")
            self.searchActive = true
            
            
            self.listaFiltrada = self.listaDeCategorias?.filter{_ in
                var found: Bool = false
                guard let textSearch = self.searchBar.text?.lowercased() else {return false}
                print(self.TAG + "Looking for \(textSearch) via searchBar...")
                
                for category in self.listaDeCategorias! {
                    if(category.name?.contains(textSearch))!{
                        found = true
                        
                    }
                    
                }
                return found
                
                
            }
            print("AQUI BUCETA 2: \(self.listaFiltrada?.count)")
            self.tableView.reloadData()
            
        }
       
        
    }
    
    
    
    
    
    
    //Mark: Metodo do observador do FirebaseService - usado para reload da tableview assim que os dados forem baixados da web
    @objc func methodOfReceivedNotification(notification: Notification) {
        print("Recebida a notificacao")
        self.listaDeCategorias = ModelSingleton.shared.categories
        self.tableView.reloadData()
    }


}

