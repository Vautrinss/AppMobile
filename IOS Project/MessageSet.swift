//
//  MessageSet.swift
//  IOS Project
//
//  Created by Leo PERNELLE on 08/03/2017.
//  Copyright © 2017 leobaptiste. All rights reserved.
//

import Foundation
import CoreData

class MessageSet {
    
    
    //MARK: Varaibles de MessageSet
    
    var messageList : [Message]{
        get{
            var ret : [Message]
            let fetch : NSFetchRequest<Message> = Message.fetchRequest()
            do{
                ret = try fetch.execute()
            }
            catch{
                fatalError("Database problem")
            }
            return ret
        }
    }

    static var selectMess: Message?
    
    
    //MARK: Méthodes de MessageSet
    
    static func addMessage(message: Message) -> Bool{
        if CoreDataManager.save() == nil { // pas d'erreur
            return true
        }
        return false
    }
    
    static func deleteMessage(message: Message) -> Bool{
        
        CoreDataManager.context.delete(message)
        if CoreDataManager.save() == nil { // pas d'erreur
            return true
        }
        return false
    }

    

}

