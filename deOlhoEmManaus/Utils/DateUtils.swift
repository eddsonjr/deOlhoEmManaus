//
//  DateUtils.swift
//  deOlhoEmManaus
//
//  Created by Edson  Jr on 09/03/20.
//  Copyright © 2020 Edson  Jr. All rights reserved.
//

import Foundation


class DateUtils {
    
    //recebe como parametro uma string contendo data e hora e converte ela para o tipo Date
    class func getStringDateAndConvertToDate(dateString: String?) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
        let date = dateFormatter.date(from: dateString!)
        return date!
    }
    
    
    //Pega a data atual do sistema e converte para string seguindo o formato de data e horario
    class func getCurrentSysDate() -> String {
        let current = Date()
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "GMT")
        formatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
        let result = formatter.string(from: current)
        return result
    }
    
    
    
    //Verifica se um show deve ser mostrado ou nao com base na data final do evento
    class func checkDateToRemoveShow(showEndDate: String?) -> Bool{
        let TAG = "[DateUtils]:"
        var result = false
        
        if(showEndDate == nil){return result} //se for nil, retorna false indicando que nao deve remover aquele show
    
        let endShowDateForm = showEndDate! + " 23:59:59" //o show ira ficar disponivel ate a data e este horario
        
        let dateFromServer = getStringDateAndConvertToDate(dateString: endShowDateForm)
        let now = getStringDateAndConvertToDate(dateString: getCurrentSysDate())
        var dateServerMore5 = Calendar.current.date(byAdding: .hour, value: 5, to: dateFromServer)
        
        if(now >= dateServerMore5!){result = true} //verifica se e para remover ou nao
        print(TAG + "Now: \(now) | Show end date: \(dateFromServer) | Show end date + 5: \(dateServerMore5) | remove: \(result)")
    
        return result
    }

    
}
