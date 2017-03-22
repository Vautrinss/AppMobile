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
                ret = try CoreDataManager.context.fetch(fetch)
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
    
    
    
    
    func newGroupe(nom: String) -> Groupe{
        
        let groupe = Groupe(context: CoreDataManager.context)
        groupe.nomGroupe = nom
        return groupe
    }
    
    
    func addGroupe(groupe: Groupe) -> Bool{
        if CoreDataManager.save() == nil { // pas d'erreur
            return true
        }
        return false
    }
    
    func listGroupe() -> [Groupe]? {
        var groupes : [Groupe]
        let request : NSFetchRequest<Groupe> = Groupe.fetchRequest()
        do{
            groupes = try CoreDataManager.context.fetch(request)
            return groupes
        }
        catch let error as NSError{
            print("erreur : \(error.userInfo["message"])")
            return nil
        }
   
    }
    
    func listGroupsNames() -> [String]{
        var groupes : [Groupe]
        var ret : [String] = []
        let request : NSFetchRequest<Groupe> = Groupe.fetchRequest()
        do{
            groupes = try CoreDataManager.context.fetch(request)
            for group in groupes{
                ret.append(group.nomGroupe ?? "pas de nom de groupe")
            }
        }
        catch let error as NSError{
            print("erreur : \(error.userInfo["message"])")
        }
        return ret
    }
    
    static func deleteGroupe(groupe: Groupe) -> Bool{
        
        CoreDataManager.context.delete(groupe)
        if CoreDataManager.save() == nil { // pas d'erreur
            return true
        }
        return false
    }
    
    func groupeCorrespondant(name: String) -> Groupe? {
        var groupes : [Groupe]
        let request : NSFetchRequest<Groupe> = Groupe.fetchRequest()
        request.predicate = NSPredicate(format: "nomGroupe == %@", name)
        do{
            groupes = try CoreDataManager.context.fetch(request)
            if groupes.count == 1{
                return groupes[0]
            }
            else{
                if groupes.count == 0
                {
                    let nGroupe : Groupe = self.newGroupe(nom: name)
                    if(addGroupe(groupe: nGroupe) == false)
                    {
                        print("erreur : imossible d'ajouter le groupe")
                        return nil
                    }
                    else {
                        return nGroupe
                    }
                    
                }
                else{
                return nil
                }
            }
        }
        catch let error as NSError{
            print("erreur : \(error.userInfo["message"])")
            return nil
        }
        
    }

    
    
}

