//
//  Date.swift
//  IOS Project
//
//  Created by leopardNL on 25/03/2017.
//  Copyright © 2017 leobaptiste. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class DateHelper {
    
     static func currentDate() -> Date{
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

    static func currentDateString() -> String{
        let date = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd' 'HH:mm"
        let dateString = dateFormatter.string(from: date as Date)
        return dateString
    
    }

    static func convertNSDateToString(d : NSDate) -> String{
        let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd' 'HH:mm"
            dateFormatter.locale = NSLocale(localeIdentifier: "FR") as Locale!
            let dateString = dateFormatter.string(from: d as Date)
            return dateString
    
    }
    
}
