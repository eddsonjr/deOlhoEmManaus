//
//  DetailShowHouseViewController.swift
//  VitrineProdutos
//
//  Created by Edson  Jr on 10/01/2020.
//  Copyright © 2020 Edson  Jr. All rights reserved.
//

import Foundation
import UIKit
import GoogleMaps
import SafariServices


class DetailShowHouseViewController: UIViewController {
    

    @IBOutlet var phone2Label: UILabel!
    @IBOutlet var phone1Label: UILabel!
    @IBOutlet var enderecoTextView: UITextView!
    @IBOutlet var nomeLocalLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.nomeLocalLabel.text = ModelSingleton.shared.showSelected?.showHouse?.name
        self.enderecoTextView.text = ModelSingleton.shared.showSelected?.showHouse?.completAddress
        
        //Verificando os telefones
        if(ModelSingleton.shared.showSelected?.showHouse?.phones == nil){
            self.phone1Label.text = "Sem telefone para contato!"
            self.phone2Label.isHidden = true
        }else{
            self.phone1Label.text = ModelSingleton.shared.showSelected?.showHouse?.phones![0]
            self.phone2Label.isHidden = true
//            if((ModelSingleton.shared.showSelected?.showHouse?.phones?.count)! == 2){
//                self.phone2Label.text = ModelSingleton.shared.showSelected?.showHouse?.phones![1]
//            }
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func verMapaButton(_ sender: Any) {
        let  location = "http://maps.google.com/maps?q=" + (ModelSingleton.shared.showSelected?.showHouse?.completAddress)!
        
        let safariURL = location.addingPercentEncoding(withAllowedCharacters:  CharacterSet.urlQueryAllowed)
        
        print("\(safariURL)")
        guard let url = URL(string: safariURL!) else { return }
        let svc = SFSafariViewController(url: url)
        present(svc, animated: true, completion: nil)
        
    }
    
    
}




