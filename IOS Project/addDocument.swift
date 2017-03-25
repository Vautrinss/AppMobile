//
//  addDocument.swift
//  IOS Project
//
//  Created by leopardNL on 25/03/2017.
//  Copyright © 2017 leobaptiste. All rights reserved.
//

import Foundation
import UIKit

class addDocument: UIViewController {
    
    @IBOutlet weak var nomDoc: UITextField!
    @IBOutlet weak var urlDoc: UITextField!
	override func viewDidLoad() {
        super.viewDidLoad()
        }


     override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    	}

     func addDocument(nomDoc nom: String, urlDoc url: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else
        {
            /*alert(errorMsg: "Impossible de poster un document", userInfo: "Impossible de poster un document")*/
            return
        }
        let context = appDelegate.persistentContainer.viewContext
        
        let document = Document(context: context)
        
        document.nomDoc = nom
        document.urlDoc = url
        document.dateDoc = DateHelper.currentDate() as NSDate?
        document.auteurDoc = Session.userConnected
        
        
        
        if DocumentSet.addDocument(doc: document) {/*alertError(errorMsg: "Document envoyé", userInfo: "")} else {alertError(errorMsg: "Impossible d'ajouter un document", userInfo: "")*/}
        
        
    }
    
    

    
    @IBAction func cancelBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addBtn(_ sender: Any) {
        if (self.nomDoc.text != "") && (self.urlDoc.text != "") {
            self.addDocument(nomDoc : self.nomDoc.text!, urlDoc: self.urlDoc.text!)
            
            self.dismiss(animated: true, completion: nil)
            

        }
        
    }
    
    
}
