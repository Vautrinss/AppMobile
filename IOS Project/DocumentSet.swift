//
//  DocumentSet.swift
//  IOS Project
//
//  Created by Leo PERNELLE on 08/03/2017.
//  Copyright © 2017 leobaptiste. All rights reserved.
//

import Foundation
import CoreData

class DocumentSet {
    
    // MARK : Variables de DocumentSet
    
    var documentList : [Document]{
        get{
            var ret : [Document]
            let fetch : NSFetchRequest<Document> = Document.fetchRequest()
            do{
                ret = try fetch.execute()
            }
            catch{
                fatalError("Database problem")
            }
            return ret
        }
    }
    

    
    
    /// addDocument : sauvegarde dans la base de données le document donné en paramètre   
    static func addDocument(doc: Document) -> Bool{
        if CoreDataManager.save() == nil { // pas d'erreur
            return true
        }
        return false
    }
    
    /// deleteDocument : supprime dans la base de données le document donné en paramètre
    static func deleteDocument(doc: Document) -> Bool{
        
        CoreDataManager.context.delete(doc)
        if CoreDataManager.save() == nil { // pas d'erreur
            return true
        }
        return false
    }
    
    
    
}

