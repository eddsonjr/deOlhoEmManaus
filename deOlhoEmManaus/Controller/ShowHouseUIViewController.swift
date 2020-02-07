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
        //self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title:"", style: .plain, target: self, action: #selector(self.shareButton(_:)))
//        let shareImage: UIImage = UIImage(named: "share")!
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: shareImage, style: .plain, target: self, action: #selector(self.shareButton(_:)))
//
        
        createShareButton()
        
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
    
    
    @objc func shareButton(_ sender: Any) {
        print(self.TAG + "Sharing....")
        let image = self.imageView.image
        let imageShare = [ image! ]
        let activityViewController = UIActivityViewController(activityItems: imageShare , applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
        
    }
    
    
    func createShareButton() {
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.setImage(UIImage(named: "share"), for: .normal)
        button.addTarget(self, action:#selector(shareButton(_:)), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = barButton
    }
    
}
