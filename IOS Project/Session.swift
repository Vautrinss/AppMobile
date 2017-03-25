//
//  Session.swift
//  IOS Project
//
//  Created by Leo PERNELLE on 08/03/2017.
//  Copyright © 2017 leobaptiste. All rights reserved.
//

import Foundation
import CoreData

class Session{
    
    // MARK: - Session Variables
    
    static var personnes : PersonneSet = PersonneSet()
    static var userConnected : Personne?
    
    
     @discardableResult
    
    // MARK: - Session methods
       
    /// login : Check si le couple login-mdp correspond à un utilisateur et réfère l'utilisateur de la Session.
    
    static func login(login: String, passwd: String){
        self.userConnected = self.personnes.doesUserExist(login: login, passwd: passwd)
        let g : GroupeSet = GroupeSet()
        GroupeSet.groupeChoisi = g.groupeCorrespondant(name: "Tous")
    }
    
    // logout : Suppprime la session actuel
    
    static func logout(){
        self.userConnected = nil
    }
    
    // isUserConnected : renvoie true si il y a une session en cours false sinon
    
    static var isUserConnected : Bool{
        get{
            return self.userConnected != nil
        }
    }
    private init(){
        
    }
    
}
