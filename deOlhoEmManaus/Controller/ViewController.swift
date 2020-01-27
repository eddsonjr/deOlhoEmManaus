//
//  ViewController.swift
//  deOlhoEmManaus
//
//  Created by Edson  Jr on 24/01/2020.
//  Copyright © 2020 Edson  Jr. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UICollectionViewDataSource,UICollectionViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    
    
    private let TAG = "[ViewController]: "
    var service: FirebaseService = FirebaseService()
    var listaDeCategorias: Array<Categorie>? = []
    var atualCategoriaIndex = 0
    var collectionCell: CollectionViewCell!
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        
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
        
        cell.collectionView.delegate = self
        cell.collectionView.dataSource = self
        cell.collectionView.reloadData()
        self.atualCategoriaIndex = indexPath.section
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 256
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.listaDeCategorias!.count
    }
    
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sectionName = self.listaDeCategorias![section].name
        return sectionName
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
    
    //MARK: collectionView datasource and delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        var numberOfShowsForThisCategorie = (self.listaDeCategorias![self.atualCategoriaIndex].shows.count)
        return numberOfShowsForThisCategorie
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        self.collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! CollectionViewCell
        
        print(self.TAG + "CategoriaAtualIndex: \(self.atualCategoriaIndex) -- indexPath: \(indexPath.row)")
        let imgUrl = self.listaDeCategorias![self.atualCategoriaIndex].shows[indexPath.row].imageUrl!
        print(self.TAG + "imgUrl: \(imgUrl)")
        
        
        collectionCell.tableViewSectionNumber = self.atualCategoriaIndex
        collectionCell.imageView.loadImageUsingCache(withUrlString: imgUrl)
        
        return collectionCell
    }
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //Passando os dados de show para o singleton
        var show: Show = Show()
        let cell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
        show = self.listaDeCategorias![cell.tableViewSectionNumber].shows[indexPath.row]
        ModelSingleton.shared.showSelected = show
        print("Pegando o shwo correspondente: \(show.showHouseKey) - \(show.imageUrl)")
        print("Ainda na collection. Singleton de show: \(ModelSingleton.shared.showSelected?.imageUrl)")
        
    }
    
    
    
    @objc func methodOfReceivedNotification(notification: Notification) {
        print("Recebida a notificacao")
        self.listaDeCategorias = ModelSingleton.shared.categories
        self.tableView.reloadData()
    }


}

