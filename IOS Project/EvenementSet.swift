//
//  EvenementSet.swift
//  IOS Project
//
//  Created by bou kisrane on 25/03/2017.
//  Copyright © 2017 leobaptiste. All rights reserved.
//


import Foundation
import CoreData

class EvenementSet {
    
    var evtList : [Evenement]{
        get{
            var ret : [Evenement]
            let fetch : NSFetchRequest<Evenement> = Evenement.fetchRequest()
            do{
                ret = try fetch.execute()
            }
            catch{
                fatalError("Database problem")
            }
            return ret
        }
    }
    
    static func addEvenement(evenement: Evenement) -> Bool{
        if CoreDataManager.save() == nil { // pas d'erreur
            return true
        }
        return false
    }
    
    
}
