//
//  CoreDataManager.swift
//  IOS Project
//
//  Created by Baptiste VAUTRIN on 02/03/2017.
//  Copyright © 2017 leobaptiste. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager: NSObject {
    
    static var context : NSManagedObjectContext = {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            exit(EXIT_FAILURE)
        }
        return appDelegate.persistentContainer.viewContext
    }()
    
    @discardableResult
    class func save() -> NSError?{
    do{
        try CoreDataManager.context.save()
        return nil
    }
    catch let error as NSError{
    return error
    }
    }
    
    
    
    
}
