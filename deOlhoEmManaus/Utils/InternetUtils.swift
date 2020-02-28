//
//  InternetUtils.swift
//  deOlhoEmManaus
//
//  Created by Edson  Jr on 03/02/2020.
//  Copyright © 2020 Edson  Jr. All rights reserved.
//

import Foundation
import Alamofire




class InternetUtils {
    
    
    //Este metodo somente verifica pontualmente se ha alguma conexao com a web ou nao
    class func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
    
    
    
    //Este metodo aciona um observador que verifica a todo instante se ha ou nao conexao com a web
    class func NetworkReachabilityManagerObserver() -> Bool{
        let TAG = "[Connectivity]: "
        var isConnected = true
        let reachabilityManager = NetworkReachabilityManager()
        reachabilityManager?.startListening()
        reachabilityManager?.listener = { _ in
            if let isNetworkReachable = reachabilityManager?.isReachable,
                isNetworkReachable == false {
                //Internet NOT Available
                print(TAG + "WARNING: no internet available....")
                isConnected = false
            }
        }
        
        return isConnected
    }
}
