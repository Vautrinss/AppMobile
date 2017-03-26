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
    
    // MARK: Variables de ViewController
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var pwd: UITextField!
    
    // MARK: Méthodes de ViewController
   
    // Méthode appelé lors du clic sur le bouton connexion
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
        // Si pas d'admin(admin, admin) dans la BD alors on en cree un
        PersonneSet.existAdmin()
         
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Méthodes alert
    
       func alertError(errorMsg error : String, userInfo user: String = "")
    {
        let alert = UIAlertController(title: error, message: user, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
}

