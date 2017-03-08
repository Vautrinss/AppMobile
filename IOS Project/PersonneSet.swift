//
//  File.swift
//  IOS Project
//
//  Created by Leo PERNELLE on 08/03/2017.
//  Copyright © 2017 leobaptiste. All rights reserved.
//

import Foundation
import CoreData

class PersonneSet {
    
    
    var personneList : [Personne]{
        get{
            var ret : [Personne]
            let fetch : NSFetchRequest<Personne> = Personne.fetchRequest()
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
    
    
    func addPersonne(personne: Personne) -> Bool{
        if CoreDataManager.save() == nil { // pas d'erreur
            return true
        }
        return false
    }
    
    func deleteMessage(personne: Personne) -> Bool{
        
        CoreDataManager.context.delete(personne)
        if CoreDataManager.save() == nil { // pas d'erreur
            return true
        }
        return false
    }
    
    func doesUserExist(login: String, passwd: String) -> Personne?{
        var users : [Personne]
        let request : NSFetchRequest<Personne> = Personne.fetchRequest()
        request.predicate = NSPredicate(format: "loginP == %@", login)
        do{
            users = try request.execute()
            if users.count == 1{
                if users[0].checkPasswd(passwd: passwd){
                    return users[0]
                }
                else{
                    return nil
                }
            }
            else{
                return nil
            }
        }
        catch{
            return nil
        }
    }
    
    
    
}


