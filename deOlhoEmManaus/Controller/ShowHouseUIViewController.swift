//
//  ShowHouseUIViewController.swift
//  VitrineProdutos
//
//  Created by Edson  Jr on 09/01/2020.
//  Copyright © 2020 Edson  Jr. All rights reserved.
//

import UIKit

class ShowHouseUIViewController: UIViewController {

    
    @IBOutlet var imageView: CustomImageView!
    let TAG = "[ShowHouseViewController]: "
    @IBOutlet var detailsShowButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(self.TAG + "Singleton show: \(ModelSingleton.shared.showSelected?.id)")
        
        verifyWebAndDownload()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func contactAndAddressButton(_ sender: Any) {
        print(self.TAG + "Contact selected...")
    }
    
    
    
    
    func verifyWebAndDownload() {
        if(InternetUtils.isConnectedToInternet()) {
            print(TAG + "web available. Downloading...")
            self.imageView.loadImageUsingCache(withUrlString: (ModelSingleton.shared.showSelected?.imageUrl)!)
        }else{
            print(self.TAG + "web not available. Prevent download....")
            AlertUtils.shared.webNotAvailableAlert(view: self)
            self.detailsShowButton.isEnabled = false
        }
    }
    
    
    
}
