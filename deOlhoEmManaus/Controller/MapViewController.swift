//
//  MapViewController.swift
//  deOlhoEmManaus
//
//  Created by Edson  Jr on 24/06/21.
//  Copyright © 2021 Edson  Jr. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {

    @IBOutlet weak var enderecoTextView: UITextView!
    @IBOutlet weak var mapKitView: MKMapView!
    
    private let TAG = "[MapViewController]: "
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        enderecoTextView.text = ModelSingleton.shared.showSelected?.showHouse?.completAddress
        setupMap()
        

    }
    
    private func setupMap() {
        
        let location = convertAddressToGeolocation()
        
        if(location != nil){
            let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            let region = MKCoordinateRegion(center: location!, span: span)
            self.mapKitView.setRegion(region, animated: true)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = location!
            annotation.title = ModelSingleton.shared.showSelected?.showHouse?.name
            self.mapKitView.addAnnotation(annotation)
        }else{
            print(TAG + "Erro ao iniciar sistema de mapas")
        }
        
    }
    
    
    
    private func convertAddressToGeolocation()  -> CLLocationCoordinate2D? {
        let geocoder =  CLGeocoder()
        var coordinate: CLLocationCoordinate2D?
        
        let address = "Amazonas Shopping"
        
        geocoder.geocodeAddressString(address, completionHandler: {(placemarks, error) -> Void in
                    if((error) != nil){
                        print("Error", error ?? "")
                    }
                    if let placemark = placemarks?.first {
                        let coordinates:CLLocationCoordinate2D = placemark.location!.coordinate
                        print("Lat: \(coordinates.latitude) -- Long: \(coordinates.longitude)")
                        
                        coordinate = coordinates
                    }
            
                })
    
       
        return coordinate
    }

}
