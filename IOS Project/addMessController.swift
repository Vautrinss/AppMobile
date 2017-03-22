//
//  ViewController.swift
//  IOS Project
//
//  Created by Baptiste VAUTRIN on 13/02/2017.
//  Copyright © 2017 leobaptiste. All rights reserved.
//

import UIKit
import CoreData

class addMessController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
   
    @IBOutlet weak var newMessageObjet: UITextField!
    
    @IBOutlet weak var newMessage: UITextView!

    @IBOutlet weak var groupe: UIPickerView!
    
    var pickerData: [String] = []
    var g: GroupeSet = GroupeSet()
    var groupeChoisi: String = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.pickerData = g.listGroupsNames(list: g.listGroupe(personne: Session.userConnected!)!)
        
        // Connect data:
        self.groupe.delegate = self
        self.groupe.dataSource = self
        
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

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        self.groupeChoisi = pickerData[row] as String

    }
    
    
    func alertError(errorMsg error : String, userInfo user: String = "")
    {
        let alert = UIAlertController(title: error, message: user, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    
    
    @IBAction func cancel(_ sender: Any) {
        self.performSegue(withIdentifier: "retourActu", sender: self)
        
    }

   
    @IBAction func send(_ sender: Any) {
        
        print(groupeChoisi)
        if (self.newMessage.text != "") && (self.newMessageObjet.text != ""){
            self.addActu(contenuActu: self.newMessage.text, objetActu: self.newMessageObjet.text!)
        
            self.performSegue(withIdentifier: "retourActu", sender: self)
        }
    }
    
    
    
    func addActu(contenuActu contenu: String, objetActu objet: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else
        {
            alertError(errorMsg: "Impossible de poster un message", userInfo: "Impossible de poster un message")
            return
        }
        let context = appDelegate.persistentContainer.viewContext
        
        let message = Message(context: context)
        
        message.objetM = objet
        message.contenuM = contenu
        message.adresser = g.groupeCorrespondant(name: groupeChoisi)
        message.auteurMess = Session.userConnected
        
        
        
        if MessageSet.addMessage(message: message) {alertError(errorMsg: "Message envoyé", userInfo: "")} else {alertError(errorMsg: "Impossible d'ajouter une actualité", userInfo: "")}
        
        
    }
    
   
    
}
