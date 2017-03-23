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
    static var personnes : PersonneSet = PersonneSet()
    static var userConnected : Personne?
    
    
    static func login(login: String, passwd: String){
        self.userConnected = self.personnes.doesUserExist(login: login, passwd: passwd)
        let g : GroupeSet = GroupeSet()
        GroupeSet.groupeChoisi = g.groupeCorrespondant(name: "Tous")
    }
    static func logout(){
        self.userConnected = nil
    }
    static var isUserConnected : Bool{
        get{
            return self.userConnected != nil
        }
    }
    private init(){
        
    }
    
}
