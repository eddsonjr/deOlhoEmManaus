//
//  UIImageExtensions.swift
//  VitrineProdutos
//
//  Created by Edson  Jr on 04/11/2019.
//  Copyright © 2019 Edson  Jr. All rights reserved.
//

import Foundation
import UIKit
import Firebase



let imageCache = NSCache<NSString, UIImage>()
extension UIImageView {
    
    
    
    func loadImageFirebaseStorage(withUrl urlString : String) {
        
        //Inicializando a animacao do activity indicator
        let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView.init(activityIndicatorStyle: .whiteLarge)
        activityIndicator.color = .black
        activityIndicator.startAnimating()
        addSubview(activityIndicator)
        
        
        let storage = Storage.storage()
        var reference: StorageReference!
        reference = storage.reference(forURL: urlString)
        reference.downloadURL { (url, error) in
            let data = NSData(contentsOf: url!)
            let image = UIImage(data: data! as Data)
            self.image = image

        }
        
        
        
        
        
    }
    
    
    
    
    //Este metodo faz do download de imagens com base na URL informada.
    func loadImageUsingCache(withUrl urlString : String) {
        let url = URL(string: urlString)
        if url == nil {return}
        self.image = nil

        // check cached image
        if let cachedImage = imageCache.object(forKey: urlString as NSString)  {
            self.image = cachedImage
            return
        }

        let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView.init(activityIndicatorStyle: .whiteLarge)
        activityIndicator.color = .black
        activityIndicator.startAnimating()
        activityIndicator.center.x = self.frame.width/2
        activityIndicator.center.y = self.frame.height/2
        addSubview(activityIndicator)
       
        

        // if not, download image from url
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }

            DispatchQueue.main.async {
                if let image = UIImage(data: data!) {
                    imageCache.setObject(image, forKey: urlString as NSString)
                    self.image = image
                    activityIndicator.removeFromSuperview()
                }
            }

        }).resume()
    }
}
