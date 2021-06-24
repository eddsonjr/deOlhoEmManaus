//
//  ViewController.swift
//  deOlhoEmManaus
//
//  Created by Edson  Jr on 24/01/2020.
//  Copyright © 2020 Edson  Jr. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UICollectionViewDataSource,UICollectionViewDelegate,UISearchBarDelegate, ReachabilityObserverDelegate {
    
    
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var noWebView: UIView!
    
    private let TAG = "[ViewController]: "
    var service: FirebaseService = FirebaseService()
    var listaDeCategorias: Array<Categorie>? = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        
        // Register to receive notification
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name("NotificationIdentifier"), object: nil)
        
        try? addReachabilityObserver() //habilitando sistema para verificar se ha ou nao conexao com web
        
        //Configurando a xib que sera usada como header
        let headerNib = UINib.init(nibName: "CustomTableViewHeaderEventListScreen", bundle: nil)
        
        self.tableView.register(headerNib, forHeaderFooterViewReuseIdentifier: "tableViewHeader")
        
        
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
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "tableViewHeader") as! CustomTableViewHeader
        headerView.label.text = self.listaDeCategorias![section].name!.capitalized
        return headerView
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    
    
    //MARK: collectionView datasource and delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return self.listaDeCategorias![collectionView.tag].shows.count
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! CollectionViewCell
        
        var imgUrl = ""
        var address = ""
    
        imgUrl = self.listaDeCategorias![collectionView.tag].shows[indexPath.row].imageUrl!
        address = self.listaDeCategorias![collectionView.tag].shows[indexPath.row].showHouse!.name!
    
        cell.textView.text = address
        cell.imageView.loadImageUsingCache(withUrl: imgUrl)
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //Passando os dados de show selecionado pelo usuario para o singleton
        var show: Show = Show()
        show = self.listaDeCategorias![collectionView.tag].shows[indexPath.row]
        ModelSingleton.shared.showSelected = show
    }
    
    
    
    
    
    
    //Mark: Metodo do observador do FirebaseService - usado para reload da tableview assim que os dados forem baixados da web
    @objc func methodOfReceivedNotification(notification: Notification) {
        print("Recebida a notificacao")
        self.listaDeCategorias = ModelSingleton.shared.categories
        self.tableView.reloadData()
        
        
        print(TAG + "Categorias: \(self.listaDeCategorias?.count)")
    }
    
    
    
    //Mark: Reachability protocol
    func reachabilityChanged(_ isReachable: Bool) {
        if isReachable {
            //conectado
            if self.listaDeCategorias!.isEmpty{
                print(TAG + "web available and datasource empty. Downloading...")
                self.noWebView.isHidden = true
                self.service.retrieveDataFromWeb()
            }
            
            
        }else{
            //desconectado
            print(TAG + "web not available. Prevent download....")
            if self.listaDeCategorias!.isEmpty {
                self.noWebView.isHidden = false
                AlertUtils.shared.webNotAvailableAlert(view: self)
            }
        }
    }
    
    
    deinit {
       removeReachabilityObserver()
       
    }
    
    
}

