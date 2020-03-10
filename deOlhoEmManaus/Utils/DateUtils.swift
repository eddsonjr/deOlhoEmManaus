//
//  DateUtils.swift
//  deOlhoEmManaus
//
//  Created by Edson  Jr on 09/03/20.
//  Copyright © 2020 Edson  Jr. All rights reserved.
//

import Foundation


class DateUtils {
    
    class func getStringDateAndConvertToDate(dateString: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let date = dateFormatter.date(from: dateString)
        return date!
    }
    
    
    class func getCurrentSysDate() -> String {
        let current = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        let result = formatter.string(from: current)
        return result
    }
    
    
    
    
    class func checkDateToRemoveBanner(dateFromServer: String?) -> Bool  {
        
        var currentDateIsSuperior = false
        if(dateFromServer == nil){
            return currentDateIsSuperior
        }
        
        let dateServer = getStringDateAndConvertToDate(dateString: dateFromServer!)
        let currentSysDate = getStringDateAndConvertToDate(dateString: getCurrentSysDate())
        var dateServerMore5 = Calendar.current.date(byAdding: .hour, value: 5, to: dateServer)
        

        if (currentSysDate >= dateServerMore5!) {
            currentDateIsSuperior = true
        }
        
        return currentDateIsSuperior
    }

    
}
