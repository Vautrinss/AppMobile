//
//  ViewController.swift
//  IOS Project
//
//  Created by Baptiste VAUTRIN on 13/02/2017.
//  Copyright © 2017 leobaptiste. All rights reserved.
//

import UIKit
import CoreData

class FilActuView: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate{
   @IBOutlet weak var actuTable: UITableView!
    var actus : [Message] = []
    
    @IBOutlet weak var newMessage: UITextView!
    
    fileprivate lazy var messagesFetched : NSFetchedResultsController<Message> = {
        let request : NSFetchRequest<Message> = Message.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key:#keyPath(Message.objetM), ascending:true)]
        let fetchResultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataManager.context, sectionNameKeyPath:nil, cacheName:nil)
        fetchResultController.delegate = self
        return fetchResultController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        do{
            //try self.actus = context.fetch(request)
            try self.messagesFetched.performFetch()
            
        }
        catch let error as NSError{
            self.alertError(errorMsg: "\(error)", userInfo: "\(error.userInfo)")
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.actuTable.dequeueReusableCell(withIdentifier: "actuCell", for: indexPath)
            as! ActuViewCellTableViewCell
        let message = self.messagesFetched.object(at: indexPath)
        cell.ObjetActu.text = message.objetM
        cell.ContenuActu.text = message.contenuM
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = self.messagesFetched.sections?[section] else {
            fatalError("Arrrgh")
        }
        return section.numberOfObjects
    }
    
    func alertError(errorMsg error : String, userInfo user: String = "")
    {
        let alert = UIAlertController(title: error, message: user, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    
    @IBAction func envoyer(_ sender: Any) {
        if self.newMessage.text != ""{
            addActu(contenuActu: self.newMessage.text)
        }
    }
    
    
    func addActu(contenuActu contenu: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else
        {
            self.alertError(errorMsg: "Impossible de poster un message", userInfo: "Impossible de poster un message")
            return
        }
        let context = appDelegate.persistentContainer.viewContext
        
        let message = Message(context: context)
        
        message.objetM = "Bonjour"
        message.contenuM = contenu
        
        do{
            try context.save()
        }
        catch let error as NSError{
            self.alertError(errorMsg: "\(error)", userInfo: "\(error.userInfo)")
            return
        }
    }
    
}

