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
    
    @IBOutlet var ruaLabel: UILabel!
    @IBOutlet var numeroLabel: UILabel!
    @IBOutlet var bairroLabel: UILabel!
    @IBOutlet var cepLabel: UILabel!
    @IBOutlet var nomeLocalLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.phone1Label.text = ShowSingleton.shared.show?.showHouse?.phone1
        self.ruaLabel.text = ShowSingleton.shared.show?.showHouse?.street
        self.bairroLabel.text = ShowSingleton.shared.show?.showHouse?.neighborhood
        self.numeroLabel.text = ShowSingleton.shared.show?.showHouse?.number
        self.cepLabel.text = ShowSingleton.shared.show?.showHouse?.zip
        self.nomeLocalLabel.text = ShowSingleton.shared.show?.showHouse?.name
        
        
        if(ShowSingleton.shared.show?.showHouse?.phone2 != nil ||  ShowSingleton.shared.show?.showHouse?.phone2 != ""){
            self.phone2Label.text = ShowSingleton.shared.show?.showHouse?.phone2
        }
        

        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func verMapaButton(_ sender: Any) {
        
        let latitude = ShowSingleton.shared.show?.showHouse?.latitude
        let longitude = ShowSingleton.shared.show?.showHouse?.longitude
        
        let camera = GMSCameraPosition.camera(withLatitude: latitude!, longitude: longitude!, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
        
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: latitude!, longitude: longitude!)
        marker.map = mapView
        
    }
    
}




