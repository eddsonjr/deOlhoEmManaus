//
//  DateUtils.swift
//  deOlhoEmManaus
//
//  Created by Edson  Jr on 09/03/20.
//  Copyright © 2020 Edson  Jr. All rights reserved.
//

import Foundation


class DateUtils {
    
    class func getStringDateAndConvertToDate(dateString: String?) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let date = dateFormatter.date(from: dateString!)
        return date!
    }
    
    
    class func getCurrentSysDate() -> String {
        let current = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        let result = formatter.string(from: current)
        return result
    }
    
    
    
    class func getTimeStamp(dateString: String) -> Int{
        var dfmatter = DateFormatter()
        dfmatter.dateFormat="dd/MM/yyyy"
        var date = dfmatter.date(from: dateString)
        var dateStamp:TimeInterval = date!.timeIntervalSince1970
        var dateSt:Int = Int(dateStamp)
        return dateSt
    }
    
    
    
    
    class func checkDateToRemoveShow(showEndDate: String?) -> Bool{
        let TAG = "[DateUtils]:"
        let result = false
        
        if(showEndDate == nil){return result} //se a data do show for nula, retorna false para indicar que aquele show nao sera removido
        
        let showEndDateTS = getTimeStamp(dateString: showEndDate!)
        let currentDate = getCurrentSysDate()
        print(TAG + "Show end date: \(showEndDate) TS: \(showEndDateTS) | Now: \(currentDate) TS: \(getTimeStamp(dateString: currentDate))")
    
       
        
        
        
        
        return result
    }
    
    
    
    
    class func checkDateToRemoveBanner(dateFromServer: String?) -> Bool  {
        
        let TAG = "[DateUtils]:"
        
        var currentDateIsSuperior = false
        if(dateFromServer == nil){
            return currentDateIsSuperior
        }
        
        let dateServer = getStringDateAndConvertToDate(dateString: dateFromServer!)
        let currentSysDate = getStringDateAndConvertToDate(dateString: getCurrentSysDate())
        var dateServerMore5 = Calendar.current.date(byAdding: .hour, value: 5, to: dateServer)
        
        if (currentSysDate >= dateServer) {
            currentDateIsSuperior = true
        }
        
        print(TAG + "D Server: \(dateServer) | sysD: \(currentSysDate) | dS+5: \(dateServerMore5) | rem: \(currentDateIsSuperior)")
        
        return currentDateIsSuperior
    }

    
}
