//
//  AlertUtils.swift
//  deOlhoEmManaus
//
//  Created by Edson  Jr on 03/02/2020.
//  Copyright © 2020 Edson  Jr. All rights reserved.
//

import Foundation
import UIKit


class AlertUtils{
    
    static let shared = AlertUtils()

    func webNotAvailableAlert(view: UIViewController) {
        let alertController = UIAlertController(
            title: "Conexão com a web",
            message: "Parece que você não está conectado a internet. Por favor verifique a sua conexão e tente novamente.",
            preferredStyle: .alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: { action in
        })
        alertController.addAction(defaultAction)
        DispatchQueue.main.async(execute: {
            view.present(alertController, animated: true)
        })
    }
        
}
    

