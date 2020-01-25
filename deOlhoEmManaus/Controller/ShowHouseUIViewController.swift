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
    

    override func viewDidLoad() {
        super.viewDidLoad()
        print(self.TAG + "Singleton show: \(ModelSingleton.shared.showSelected?.id)")
        self.imageView.loadImageUsingCache(withUrlString: (ModelSingleton.shared.showSelected?.imageUrl)!)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func contactAndAddressButton(_ sender: Any) {
        print(self.TAG + "Contact selected...")
    }
    
}
