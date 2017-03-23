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
    
    @IBOutlet weak var addUser: UIButton!
    

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
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    @IBAction func changeMdp(_ sender: Any) {
        let popupMdp = UIAlertController(title: "Modifier le mot de passe", message: "mdp", preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Modifier", style: .default)
        {
            [unowned self] action in
            guard let textField = popupMdp.textFields?.first,
                let nameToSave = textField.text else {
                    return
                }

        }
        
        let cancelAction = UIAlertAction(title: "Annuler", style: .default)
        

        
        present(popupMdp, animated: true)


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

