//
//  ViewController.swift
//  IOS Project
//
//  Created by Baptiste VAUTRIN on 13/02/2017.
//  Copyright © 2017 leobaptiste. All rights reserved.
//

import UIKit
import CoreData

class FilActuView: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource{
   @IBOutlet weak var actuTable: UITableView!

    @IBOutlet weak var choixGroupe: UIPickerView!
    
    var pickerData: [String] = []
    var groupe: GroupeSet = GroupeSet()
    
    

    
    fileprivate lazy var messagesFetched : NSFetchedResultsController<Message> = {
        let request : NSFetchRequest<Message> = Message.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key:#keyPath(Message.objetM), ascending:true)]
        request.predicate = NSPredicate(format: "adresser == %@", GroupeSet.groupeChoisi!)
        let fetchResultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataManager.context, sectionNameKeyPath:nil, cacheName:nil)
        fetchResultController.delegate = self
        return fetchResultController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if(GroupeSet.grChoix == nil) { GroupeSet.grChoix = 0 }
        choixGroupe.selectRow(GroupeSet.grChoix!, inComponent: 0, animated: true)

        
        do{
            //try self.actus = context.fetch(request)
            try self.messagesFetched.performFetch()
            
        }
        catch let error as NSError{
            self.alertError(errorMsg: "\(error)", userInfo: "\(error.userInfo)")
        }
        
        if Session.userConnected?.statutP == 1
        {
        self.pickerData = groupe.listGroupsNames(list: groupe.listGroupe()!)
        }
        else{
        self.pickerData = groupe.listGroupsNames(list: groupe.listGroupe(personne: Session.userConnected!)!)
        }
        
        
        // Connect data:
        self.choixGroupe.delegate = self
        self.choixGroupe.dataSource = self
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.actuTable.dequeueReusableCell(withIdentifier: "actuCell", for: indexPath)
            as! ActuViewCellTableViewCell
        let message = self.messagesFetched.object(at: indexPath)
        cell.ObjetActu.text = message.auteurMess?.nomP
        cell.ContenuActu.text = message.objetM
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = self.messagesFetched.sections?[section] else {
            fatalError("Arrrgh")
        }
        return section.numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
   func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle==UITableViewCellEditingStyle.delete){
            self.actuTable.beginUpdates()
            self.deleteActu(messageWithIndex: indexPath)
            self.actuTable.endUpdates()
    }
    }
    
    
        func getContext(errorMsg: String, userInfoMsg: String = "error") -> NSManagedObjectContext?{
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                //self.alert(WithTitle: errorMsg, andMessage: UserInfoMsg)
                return nil
            }
            return appDelegate.persistentContainer.viewContext
        }
    
    func alert(WithTitle title: String, andMessage msg: String = "") {
        let alert = UIAlertController(title: title,
                                      message: msg,
                                      preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Ok",
                                         style: .default)
        alert.addAction(cancelAction)
        present(alert,animated: true)
    }
    

    
    
    func alertError(errorMsg error : String, userInfo user: String = "")
    {
        let alert = UIAlertController(title: error, message: user, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    func deleteActu(messageWithIndex indexPath: IndexPath){
            let message = self.messagesFetched.object(at: indexPath)
            if MessageSet.deleteMessage(message: message) {alert(WithTitle: "OK", andMessage: "")} else {alert(WithTitle: "Impossible d'ajouter une actualité", andMessage: "")}
            
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
        let a = pickerData[row] as String
        GroupeSet.groupeChoisi = self.groupe.groupeCorrespondant(name: a)
        GroupeSet.grChoix = row
        self.actuTable.reloadData()
        
        
    }
    

    
    
    
}
