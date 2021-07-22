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
    
    
    //Este metodo serve para verificar se um request ira retornar erro
    //caso seja encontrado algum erro (404/503), sera retornado true
    //caso o request seja diferente de 404, ira retornar false
    class func checkWebRequestForErros(urlAddress: String) -> Bool {
        var requestError = false
        let url = URL(string: urlAddress)!
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) {data, response, error in
            let httpResponse = response as? HTTPURLResponse
            if(httpResponse?.statusCode == 404 || httpResponse?.statusCode == 503){
                requestError = true
            }
        }
        task.resume()
        return requestError
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
