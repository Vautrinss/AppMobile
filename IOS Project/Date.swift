//
//  Date.swift
//  IOS Project
//
//  Created by leopardNL on 25/03/2017.
//  Copyright © 2017 leobaptiste. All rights reserved.
//

import Foundation

class Date {
    
    static class func currentDate() -> Date{
        let date = NSDate()
        let calendar = NSCalendar.current
        let dateNeeded = calendar.dateComponents([.year, .month,.day], from: date as Date)
        let year : String = String(format: "%04d", dateNeeded.year!)
        let month = String(format: "%02d", dateNeeded.month!)
        let day = String(format:"%02d",dateNeeded.day!)
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        let result = formatter.date(from :day+"-"+month+"-"+year)
        return result!
    
    }

    static class func currentDateString() -> String{
        let date = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd' 'HH:mm"
        let dateString = dateFormatter.string(from: date as Date)
        return dateString
    
    }

        class func convertNSDateToString(d : NSDate) -> String{
        let date = d
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd' 'HH:mm"
        let dateString = dateFormatter.string(from: date as Date)
        return dateString
    
    }
    
}
