//
//  File.swift
//  IOS Project
//
//  Created by Leo PERNELLE on 08/03/2017.
//  Copyright © 2017 leobaptiste. All rights reserved.
//

import Foundation
import CoreData

extension Personne {
// Ici methode pour crypter password
// Methode verification password (renvoi un bol)
    
    
    
    static func newPersonne(prenom: String, nom: String, passwd: String, statut: Int16, promo: String) -> Personne{
        
        let g: GroupeSet = GroupeSet()
        let personne = Personne(context: CoreDataManager.context)
        personne.nomP = nom
        personne.prenomP = prenom
        personne.password = passwd
        personne.statutP = statut
        personne.addToAppartenir(g.groupeCorrespondant(name: "Tous")!)
        if(statut == 4){
            personne.addToAppartenir(g.groupeCorrespondant(name: promo)!)
        }
        else if(statut == 3){
            personne.addToAppartenir(g.groupeCorrespondant(name: "Enseignant")!)
        }
        else {
            personne.addToAppartenir(g.groupeCorrespondant(name: "Secretariat")!)
        }
        return personne
    }
    
    var login : String{
        get{
            return self.prenom+"."+self.nom
        }
    }
    var prenom : String{
        get{
            return self.prenomP ?? ""
        }
        set{
            self.prenomP = newValue
        }
    }
    var nom : String{
        get{
            return self.nomP ?? ""
        }
        set{
            self.nomP = newValue
        }
    }
    
    var password : String{
        get{
            return self.passwordP ?? ""
        }
        set{
            self.passwordP = newValue
        }
    }
    
    func checkPasswd(passwd: String) -> Bool{
        return self.passwordP == passwd
    }
    
    func modifyPwd(pwd: String) -> Bool{
            self.setValue(pwd, forKey: "passwordP")
            if CoreDataManager.save() == nil { // pas d'erreur
                return true
            }
        
        return false
    }
    
}
