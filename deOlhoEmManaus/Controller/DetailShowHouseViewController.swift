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


class DetailShowHouseViewController: UIViewController {
    

    @IBOutlet var phone2Label: UILabel!
    @IBOutlet var phone1Label: UILabel!
    @IBOutlet var enderecoTextView: UITextView!
    @IBOutlet var nomeLocalLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.nomeLocalLabel.text = ModelSingleton.shared.showSelected?.showHouse?.name
        
        self.enderecoTextView.text = ModelSingleton.shared.showSelected?.showHouse?.completAddress
        
        //self.phone1Label.text = ModelSingleton.shared.showSelected?.showHouse?.phones![0]
        
        
//        if(!(ModelSingleton.shared.showSelected?.showHouse?.phones![1].isEmpty)!) {
//            self.phone2Label.text = ModelSingleton.shared.showSelected?.showHouse?.phones![1]
//        }
        

        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func verMapaButton(_ sender: Any) {
        
        //TODO - IMPLEMENTAR BASEADO NO ENDERECO E NAO MAIS NA LONGITUDE E NA LATITUDE
        
//        let latitude = ModelSingleton.shared.showSelected?.showHouse?.latitude
//        let longitude = ShowSingleton.shared.show?.showHouse?.longitude
//
//        let camera = GMSCameraPosition.camera(withLatitude: latitude!, longitude: longitude!, zoom: 6.0)
//        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
//        view = mapView
//
//
//        let marker = GMSMarker()
//        marker.position = CLLocationCoordinate2D(latitude: latitude!, longitude: longitude!)
//        marker.map = mapView
        
    }
    
    
}




