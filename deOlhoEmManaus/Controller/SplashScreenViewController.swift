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
                          duration: 1.75,
                          options: .transitionCrossDissolve,
                          animations: {  self.splashScreenImage.image = self.splashImage},
                          completion: {_ in
                            self.callMainScreen()
                          })
    }
    
    
    private func callMainScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let mainView = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController

        let navigationController = UINavigationController(rootViewController: mainView)
        appDelegate.window!.rootViewController = navigationController

    }
    

}
