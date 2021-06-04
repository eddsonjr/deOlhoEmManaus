//
//  SplashScreenViewController.swift
//  deOlhoEmManaus
//
//  Created by Edson  Jr on 04/06/21.
//  Copyright © 2021 Edson  Jr. All rights reserved.
//

import UIKit

class SplashScreenViewController: UIViewController {

    @IBOutlet weak var splashScreenImage: UIImageView!
    let splashImage = UIImage(named: "new_logo.png")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animate()
 
    }
    
    
    private func animate(){
        UIView.transition(with: self.splashScreenImage,
                          duration: 0.7,
                          options: .transitionCrossDissolve,
                          animations: {  self.splashScreenImage.image = self.splashImage},
                          completion: nil)
    }
    
    
    private func callMainScreen() {
        
    }
    

}
