//
//  ProfilController.swift
//  IOS Project
//
//  Created by Leo PERNELLE on 15/03/2017.
//  Copyright © 2017 leobaptiste. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class ProfilController: UIViewController {
    
    
    @IBOutlet weak var lastName: UITextField!
    
    @IBOutlet weak var firstName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func deconnexion(_ sender: Any) {
        
        Session.logout()
        self.performSegue(withIdentifier: "deconnexion", sender: self)
    
    }

    func alertError(errorMsg error : String, userInfo user: String = "")
    {
        let alert = UIAlertController(title: error, message: user, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    
    func addUser(firstName p1 : String, lastName p2 : String)
    {
    var personnes : [Personne]
    let pwd = p1 + "." + p2
    let request : NSFetchRequest<Personne> = Personne.fetchRequest()
    let predicate : NSPredicate = NSPredicate(format: "nomP = %@", firstName)
    request.predicate = predicate
    do{
    personnes = try CoreDataManager.context.fetch(request)
    }
    catch let error as NSError{
    fatalError("erreur executing fetchRequest : \(error)")
    }
    if personnes.count == 0{
    let leo = Personne.newPersonne(prenom: p1, nom: p2, passwd: pwd, statut: 1)
    leo.loginP = pwd
    if PersonneSet.addPersonne(personne: leo) {alertError(errorMsg: "Utilisteur créé", userInfo: "")} else {alertError(errorMsg: "Impossible d'ajouter un utilisateur", userInfo: "")}
    }
    else{
    print("leo is living")
    }
        
    }
    

    @IBAction func add(_ sender: Any) {
        if (self.lastName.text != "") && (self.firstName.text != ""){
            self.addUser(firstName: firstName.text!, lastName: lastName.text!)
        }
    }


    
}

