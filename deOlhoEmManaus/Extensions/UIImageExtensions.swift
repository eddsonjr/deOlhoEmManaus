//
//  UIImageExtensions.swift
//  VitrineProdutos
//
//  Created by Edson  Jr on 04/11/2019.
//  Copyright © 2019 Edson  Jr. All rights reserved.
//

import Foundation
import UIKit


let imageCache = NSCache<NSString, UIImage>() //variavel global de cache

//Esta classe serve para baixar a imagem da internet e salvar em cache
class CustomImageView: UIImageView {
    
    var activityIndicatorView: UIActivityIndicatorView = {
        var activity = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
        activity.color = .black
        activity.translatesAutoresizingMaskIntoConstraints = false
        
        return activity
    }()
    
    var imageUrlString: String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupView()
    }
    
    override init(image: UIImage?) {
        super.init(image: image)
        self.setupView()
    }
    
    init() {
        super.init(frame: CGRect.zero)
    }
    
    func setupView() {
        self.addSubview(self.activityIndicatorView)
        
        self.activityIndicatorView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        self.activityIndicatorView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        self.activityIndicatorView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        self.activityIndicatorView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        self.activityIndicatorView.color = UIColor.black
    }
    
    func loadImageUsingCache(withUrlString: String, _ completion: ((_ image: UIImage?) -> Void)? = nil) {
        if withUrlString == "" {
            self.image = nil
            DispatchQueue.main.sync {
                completion?(nil)
            }
            return
        }
        
        imageUrlString = withUrlString
        self.image = nil
        
        self.activityIndicatorView.startAnimating()
        
        let url = URL(string: withUrlString)
        
        if let imageFromCache = imageCache.object(forKey: withUrlString as NSString) {
            self.image = imageFromCache
            self.activityIndicatorView.stopAnimating()
            completion?(imageFromCache)
            return
        }
        
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            if error != nil {
                completion?(nil)
                return
            }
            DispatchQueue.main.sync {
                
                let imageToCache = UIImage(data: data!)
                
                if self.imageUrlString == withUrlString {
                    self.image = imageToCache
                    self.activityIndicatorView.stopAnimating()
                    
                    if let i = imageToCache {
                        imageCache.setObject(i, forKey: withUrlString as NSString)
                    }
                    completion?(imageToCache)
                }
            }
        }).resume()
    }
    
}



extension UIImage {
    
    class func loadImage(withUrl url: String, completion: @escaping (_ image: UIImage?) -> Void) -> () {
        let u = URL(string: url)
        
        if let imageFromCache = imageCache.object(forKey: url as NSString) {
            completion(imageFromCache)
            return
        }
        
        URLSession.shared.dataTask(with: u!, completionHandler: { (data, response, error) in
            if error != nil {
                completion(nil)
                return
            }
            DispatchQueue.main.sync {
                
                let imageToCache = UIImage(data: data!)
                
                imageCache.setObject(imageToCache!, forKey: url as NSString)
                completion(imageToCache)
            }
        }).resume()
    }
    
}







//Extensao para somente baixar a imagem da web (sem cache)
extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}


