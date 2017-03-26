//
//  addUserController.swift
//  IOS Project
//
//  Created by Leo PERNELLE on 22/03/2017.
//  Copyright © 2017 leobaptiste. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class addUserController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {
    
    

    @IBOutlet weak var lastName: UITextField!
    
    @IBOutlet weak var firstName: UITextField!

    @IBOutlet weak var statut: UIPickerView!

    @IBOutlet weak var promo: UITextField!
    
    @IBOutlet weak var promoLabel: UILabel!
    
    @IBOutlet weak var promoInput: UITextField!
    
    //
    var pickerData: [String] = []
    var choixStatut: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        pickerData = ["Etudiant", "Enseignant", "Secretaire", "Responsable departement"]
        // Connect data:
        self.statut.delegate = self
        self.statut.dataSource = self
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(pickerData[row] == "Etudiant")
        {
            self.promoLabel.isEnabled = true
            self.promoInput.isEnabled = true
            self.promoLabel.isHidden = false
            self.promoInput.isHidden = false
        }
        else {
            self.promoLabel.isEnabled = false
            self.promoInput.isEnabled = false
            self.promoLabel.isHidden = true
            self.promoInput.isHidden = true
        }
        self.choixStatut = self.pickerData[row]
    }

    
    
    
    
    
    func alertError(errorMsg error : String, userInfo user: String = "")
    {
        let alert = UIAlertController(title: error, message: user, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    

    
    func addUser(firstName p1 : String, lastName p2 : String, promo promotion: String, statut s: Int16)
    {
        var personnes : [Personne]
        let mdp = p1 + "." + p2
        let pwd = mdp.sha1()
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
            let leo = Personne.newPersonne(prenom: p1, nom: p2, passwd: pwd, statut: s)
            leo.loginP = pwd
            if PersonneSet.addPersonne(personne: leo) {
                leo.addGroupe(promo: promotion)
                alertError(errorMsg: "Utilisteur créé", userInfo: "")
            }
            else {alertError(errorMsg: "Impossible d'ajouter un utilisateur", userInfo: "")}
            
            
        }
        else{
            print("leo is living")
        }
        
    }
    
    
    @IBAction func add(_ sender: Any) {
        var choixStatut: Int16 = 1;
        if (self.lastName.text != "") && (self.firstName.text != "") {
            if(self.choixStatut == "Responsable departement"){choixStatut = 1}
            else if(self.choixStatut == "Secretaire"){choixStatut = 2}
            else if(self.choixStatut == "Enseignant"){choixStatut = 3}
            else {choixStatut = 4}
            if(choixStatut != 4) || (self.promo.text != ""){
            self.addUser(firstName: firstName.text!, lastName: lastName.text!, promo: promo.text!, statut: choixStatut)
        
            }
        }
    }
    
    
    @IBAction func cancelBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
}

