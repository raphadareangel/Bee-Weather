//
//  DateDeals.swift
//  BeeWheather
//
//  Created by Rafael Torres Balderas on 05/10/2018.
//  Copyright © 2018 Rafael Torres Balderas. All rights reserved.
//

import Foundation

class DateDeals{
    
    func dateToCompare(dateString: String) -> String {
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-ddHH:mm:ss"
        print(dateString)
        var date1 = dateFormatter.date(from: dateString )
        print(date1)
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let goodDate = dateFormatter.string(from: (date1)! )
       // print(goodDate)
        return goodDate
    }
    
    func addOneDay(dateString: String) -> String {
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        var date1 = dateFormatter.date(from: dateString )
        date1=Calendar.current.date(byAdding: .day, value: 1, to: date1!)
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let goodDate = dateFormatter.string(from: (date1)! )
        //print("haha",goodDate)
        
        return goodDate
    }
    
    func dateTohour(dateString: String) -> String {
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-ddHH:mm:ss"
        print(dateString)
        var date1 = dateFormatter.date(from: dateString )
        print(date1)
        
        dateFormatter.dateFormat = "H:mm"
        let goodDate = dateFormatter.string(from: (date1)! )
        // print(goodDate)
        return goodDate
    }
    
}
