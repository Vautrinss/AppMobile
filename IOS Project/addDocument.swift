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
	
	// MARK : Variables de addDocument	
    
    @IBOutlet weak var nomDoc: UITextField!
    @IBOutlet weak var urlDoc: UITextField!
	
	
	// MARK : Methodes de addDocument
	override func viewDidLoad() {
        super.viewDidLoad()
        
        
        }


     override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    	}
	
	//A partir des paramètres (nom et url), crée un document et l'ajoute à la base de données
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
    
    
	
    	//Lors du clic sur le bouton annuler, on retourne à la vue précédente
    @IBAction func cancelBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    	
	//Lors du clic sur le bouton ajouter, on vérifie si les champ nom et url ne son pas vide, ensuite on ajoute le nouveau document dans la base de données
    @IBAction func addBtn(_ sender: Any) {
        if (self.nomDoc.text != "") && (self.urlDoc.text != "") {
            self.addDocument(nomDoc : self.nomDoc.text!, urlDoc: self.urlDoc.text!)
            
            self.dismiss(animated: true, completion: nil)
            

        }
        
    }
    
    
}
