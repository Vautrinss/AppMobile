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
    
    
    //MARK: Variables de ProfilController
    
    @IBOutlet weak var addUser: UIButton!
    
    @IBOutlet weak var nomProfil: UILabel!

    @IBOutlet weak var prenomProfil: UILabel!
    
    //MARK: Méthodes de ProfilController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Session.userConnected?.statutP == 1
        {
            self.addUser.isEnabled = true
            self.addUser.isHidden = false
        }
        else{
            self.addUser.isHidden = true
            self.addUser.isEnabled = false
        }
        
        nomProfil.text = Session.userConnected?.nomP
        prenomProfil.text = Session.userConnected?.prenomP
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // Popup changement de Mdp

    @IBAction func changeMdp(_ sender: Any) {
        var pass1TextField: UITextField?
        var pass2TextField: UITextField?


        
        let alert = UIAlertController(title: "Modifier le mot de passe", message: "mdp", preferredStyle: .alert)
    
        
        alert.addTextField { (textField) -> Void in
            // Enter the textfiled customization code here.
            pass1TextField = textField
            pass1TextField?.placeholder = "Mot de passe"
            pass1TextField?.isSecureTextEntry = true
        }
        
        alert.addTextField { (textField) -> Void in
            // Enter the textfiled customization code here.
            pass2TextField = textField
            pass2TextField?.placeholder = "Mot de passe"
            pass2TextField?.isSecureTextEntry = true
        }
        
        let saveAction = UIAlertAction(title: "Modifier", style: .default)
        {
            [unowned self] action in
            if(pass1TextField?.text == pass1TextField?.text){
            
                guard let textField = alert.textFields?.first,
                    let passToSave = textField.text else {
                    return
                }
                
                if(Session.userConnected?.modifyPwd(pwd: passToSave) == true){
                    self.alertError(errorMsg: "Felicitation votre mot de passe est a jour")
                }
            }
            
        }
        
        
        let cancelAction = UIAlertAction(title: "Annuler", style: .default)
        

        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)

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
    
    


    
}

