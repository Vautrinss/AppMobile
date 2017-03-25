//
//  listUserController.swift
//  IOS Project
//
//  Created by Leo PERNELLE on 23/03/2017.
//  Copyright © 2017 leobaptiste. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class listUserController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate{
    
    
    
    // MARK : Variables de listUserController
    @IBOutlet weak var userTable: UITableView!
    
    fileprivate lazy var usersFetched : NSFetchedResultsController<Personne> = {
        let request : NSFetchRequest<Personne> = Personne.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key:#keyPath(Personne.loginP), ascending:true)]
        //request.predicate = NSPredicate(format: "statut != %@", "1")
        let fetchResultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataManager.context, sectionNameKeyPath:nil, cacheName:nil)
        print("OK ICI1")
        fetchResultController.delegate = self
        print("OK ICI2")
        return fetchResultController
    }()
    
    // MARK : Méthodes de listUserController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        do{
            //try self.actus = context.fetch(request)
            try self.usersFetched.performFetch()
            
        }
        catch let error as NSError{
            self.alertError(errorMsg: "\(error)", userInfo: "\(error.userInfo)")
        }
        
        /*if Session.userConnected?.statutP == 1
        {
            
        }*/
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK : Méthode tableView
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.userTable.dequeueReusableCell(withIdentifier: "userCell", for: indexPath)
            as! cellViewUserList
        let user = self.usersFetched.object(at: indexPath)
        cell.login.text = user.loginP
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = self.usersFetched.sections?[section] else {
            fatalError("Arrrgh")
        }
        return section.numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle==UITableViewCellEditingStyle.delete){
            self.userTable.beginUpdates()
            self.deleteUser(messageWithIndex: indexPath)
            self.userTable.endUpdates()
        }
    }
    
    
    func getContext(errorMsg: String, userInfoMsg: String = "error") -> NSManagedObjectContext?{
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            //self.alert(WithTitle: errorMsg, andMessage: UserInfoMsg)
            return nil
        }
        return appDelegate.persistentContainer.viewContext
    }
    
    // MARK : Méthode alert
    
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

    //MARK : Méthode Base de données
    
    func deleteUser(messageWithIndex indexPath: IndexPath){
        let user = self.usersFetched.object(at: indexPath)
        if PersonneSet.deletePersonne(user: user) {alert(WithTitle: "OK", andMessage: "")} else {alert(WithTitle: "Impossible de supprimer cet utilisateur", andMessage: "")}
        
    }
}
