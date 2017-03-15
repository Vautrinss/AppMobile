//
//  ViewController.swift
//  IOS Project
//
//  Created by Baptiste VAUTRIN on 13/02/2017.
//  Copyright © 2017 leobaptiste. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var pwd: UITextField!
    
    @IBAction func connexion(_ sender: Any) {
        if (self.username.text != "") && (self.pwd.text != "") {
            Session.login(login: self.username.text!, passwd: self.pwd.text!)
            if Session.isUserConnected
            {
                self.performSegue(withIdentifier: "connexion", sender: self)
            }else {alertError(errorMsg: "Mauvais identifiant ou mot de passe")}
        }
        else {alertError(errorMsg: "Veuillez entrer un identifiant et un mot de passe")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var personnes : [Personne]
        let request : NSFetchRequest<Personne> = Personne.fetchRequest()
        let leo : String = "leo"
        let predicate : NSPredicate = NSPredicate(format: "nomP = %@", leo)
        request.predicate = predicate
        do{
            personnes = try CoreDataManager.context.fetch(request)
        }
        catch let error as NSError{
            fatalError("erreur executing fetchRequest : \(error)")
        }
        if personnes.count == 0{
            let leo = Personne.newPersonne(prenom: "leo", nom: "leo", passwd: "leo", statut: 1)
            leo.loginP = "leo.leo"
            let error = CoreDataManager.save()
            if error != nil{
                fatalError("erreur : \(error)")
            }
        }
        else{
            print("leo is living")
        }
 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
       func alertError(errorMsg error : String, userInfo user: String = "")
    {
        let alert = UIAlertController(title: error, message: user, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
}

