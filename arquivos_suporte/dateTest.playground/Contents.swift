import UIKit
import Foundation



//Pega uma data no formato string e convert para date
func getStringDateAndConvertToDate(dateString: String) -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd.MM.yyyy"
    let date = dateFormatter.date(from: dateString)
    return date!
    
}


//pega a data atual do sistema e convert para string
func getCurrentSysDate() -> String {
    let current = Date()
    let formatter = DateFormatter()
    formatter.dateFormat = "dd.MM.yyyy"
    let result = formatter.string(from: current)
    return result
}


print(getStringDateAndConvertToDate(dateString: getCurrentSysDate()))




func checkDate(dateFromServer: String) -> Bool  {
    
    var removeBannerByHour = false
    let dateServer = getStringDateAndConvertToDate(dateString: dateFromServer)
    let currentSysDate = getStringDateAndConvertToDate(dateString: getCurrentSysDate())
    var dateServerMore5 = Calendar.current.date(byAdding: .hour, value: 5, to: dateServer)
    

    if (currentSysDate >= dateServerMore5!) {
        removeBannerByHour = true
    }
    
    return removeBannerByHour
    
}





func checkDateToRemoveBanner(dateFromServer: String?) -> Bool  {
    
    var currentDateIsSuperior = false
//    if(dateFromServer == nil){  # Remove aqueles que nao tem indicacao de end date
//        return currentDateIsSuperior
//    }
    
    let dateServer = getStringDateAndConvertToDate(dateString: dateFromServer!)
    let currentSysDate = getStringDateAndConvertToDate(dateString: getCurrentSysDate())
    var dateServerMore5 = Calendar.current.date(byAdding: .hour, value: 5, to: dateServer)
    

    print("Date server: \(dateServer) - Current sysD: \(currentSysDate) - Server d+5: \(dateServerMore5)")
    
    
    if (currentSysDate >= dateServerMore5!) {
        currentDateIsSuperior = true
    }
    
    return currentDateIsSuperior
}




//print(checkDate(dateFromServer: "08/02/2020"))
//print(checkDate(dateFromServer: "07/03/2020"))
//print(checkDate(dateFromServer: "08/03/2020"))
//print(checkDate(dateFromServer: "09/03/2020"))


print(checkDateToRemoveBanner(dateFromServer: "23/03/2020"))
print(checkDateToRemoveBanner(dateFromServer: "24/03/2020"))
print(checkDateToRemoveBanner(dateFromServer: "22/03/2020"))
print(checkDateToRemoveBanner(dateFromServer: "20/03/2020"))
print(checkDateToRemoveBanner(dateFromServer: "01/01/2019"))
print(checkDateToRemoveBanner(dateFromServer: "04/04/2020"))








