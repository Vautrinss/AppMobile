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
    
    
    //MARK: Variables de PersonneSet
    
    var personneList : [Personne]{
        get{
            var ret : [Personne]
            let fetch : NSFetchRequest<Personne> = Personne.fetchRequest()
            do{
                ret = try CoreDataManager.context.fetch(fetch)
            }
            catch{
                fatalError("Database problem")
            }
            return ret
        }
    }
    
    //MARK: Méthodes de PersonneSet
    
    
    static func addPersonne(personne: Personne) -> Bool{
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
            users = try CoreDataManager.context.fetch(request)
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
        catch let error as NSError{
            print("erreur : \(error.userInfo["message"])")
            return nil
        }
    }
    
    static func existAdmin(){
        var users : [Personne]
        let request : NSFetchRequest<Personne> = Personne.fetchRequest()
        request.predicate = NSPredicate(format: "loginP == %@", "admin")
        let mdp = "admin"
        do{
            users = try CoreDataManager.context.fetch(request)
            if (users.count == 0){
                let personne = Personne(context: CoreDataManager.context)
                personne.nomP = "Admin"
                personne.prenomP = "Admin"
                personne.password = mdp.sha1()
                personne.statutP = 1
                personne.loginP = "admin"
                self.addPersonne(personne: personne)
            }
        
        }
        catch let error as NSError{
            print("erreur : \(error.userInfo["message"])")
        }
    }
    
    
    static func deletePersonne(user: Personne) -> Bool{
        if(user.statutP != 1)
        {
        CoreDataManager.context.delete(user)
        if CoreDataManager.save() == nil { // pas d'erreur
            return true
        }
        }
        return false
    }
    
    
    
}


