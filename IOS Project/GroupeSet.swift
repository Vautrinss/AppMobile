//
//  GroupeSet.swift
//  IOS Project
//
//  Created by Leo PERNELLE on 08/03/2017.
//  Copyright © 2017 leobaptiste. All rights reserved.
//

import Foundation
import CoreData

class GroupeSet {
    
    
    var groupeList : [Groupe]{
        get{
            var ret : [Groupe]
            let fetch : NSFetchRequest<Groupe> = Groupe.fetchRequest()
            do{
                ret = try fetch.execute()
            }
            catch{
                fatalError("Database problem")
            }
            return ret
        }
    }
    
    /// <#Description#>
    ///
    /// - Parameter message: <#message description#>
    /// - Returns: <#return value description#>
    
    
    
    static func addGroupe(groupe: Groupe) -> Bool{
        if CoreDataManager.save() == nil { // pas d'erreur
            return true
        }
        return false
    }
    
    static func deleteGroupe(groupe: Groupe) -> Bool{
        
        CoreDataManager.context.delete(groupe)
        if CoreDataManager.save() == nil { // pas d'erreur
            return true
        }
        return false
    }
    
    
    
}

