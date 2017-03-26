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
    
    //MARK: Variable de GroupeSet
    
    static var groupeChoisi : Groupe?
    static var grChoix : Int?
    
    
    
    
    
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
    

    
    
    //MARK: Méthodes de GroupeSet
    
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
    
    
    //Retourne la liste de groupe de l'utilisateur passé en paramètre
    func listGroupe(personne: Personne) -> [Groupe]? {
        let a = personne.appartenir
        return a?.allObjects as! [Groupe]?
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
    
    //Retroune une liste de groupe (String) à partir des groupes donnée en paramètre
    func listGroupsNames(list: [Groupe]) -> [String]{
        
        var ret : [String] = []
        
            for group in list{
                ret.append(group.nomGroupe ?? "pas de nom de groupe")
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
    
    //Retourne l'instance de groupe qui correspond au nom du groupe passé en paramètre, si ce groupe n'existe pas, il est créé dans la base de données
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

