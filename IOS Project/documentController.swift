import Foundation
import UIKit
import CoreData

class documentController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate{
    
    // MARK : Variables de documentController
    
    @IBOutlet weak var docTable: UITableView!

    
    fileprivate lazy var docsFetched : NSFetchedResultsController<Document> = {
        let request : NSFetchRequest<Document> = Document.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key:#keyPath(Document.nomDoc), ascending:true)]
        //request.predicate = NSPredicate(format: "statut != %@", "1")
        let fetchResultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataManager.context, sectionNameKeyPath:nil, cacheName:nil)
        print("OK ICI1")
        fetchResultController.delegate = self
        print("OK ICI2")
        return fetchResultController
    }()
    
    @IBOutlet weak var addBtn: UIButton!
    // MARK : Méthodes de documentController
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (Session.userConnected?.statutP)! < 3
        {
            self.addBtn.isEnabled = true
            self.addBtn.isHidden = false
        }
        else{
            self.addBtn.isHidden = true
            self.addBtn.isEnabled = false
        }

        
        // Do any additional setup after loading the view, typically from a nib.
        do{
            //try self.actus = context.fetch(request)
            try self.docsFetched.performFetch()
            
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
    
    // MARK : Méthodes tableView
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.docTable.dequeueReusableCell(withIdentifier: "docCell", for: indexPath)
            as! cellViewDocList
        let doc = self.docsFetched.object(at: indexPath)
        cell.nomDoc.text = doc.nomDoc
        cell.auteurDoc.text = doc.auteurDoc?.nomP
        
        return cell
    }
    
    // click sur le document
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = self.docTable.dequeueReusableCell(withIdentifier: "docCell", for: indexPath)
            as! cellViewDocList
        let doc = self.docsFetched.object(at: indexPath)
        cell.nomDoc.text = doc.nomDoc
        cell.auteurDoc.text = doc.auteurDoc?.nomP
        UIApplication.shared.open(URL(string: doc.urlDoc!)!, options: [:], completionHandler: nil)


    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = self.docsFetched.sections?[section] else {
            fatalError("Arrrgh")
        }
        return section.numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (Session.userConnected?.statutP)! < 3
        {
        if(editingStyle==UITableViewCellEditingStyle.delete){
            self.docTable.beginUpdates()
            self.deleteDoc(messageWithIndex: indexPath)
            self.docTable.endUpdates()
        }
        }
    }
    
    
    func getContext(errorMsg: String, userInfoMsg: String = "error") -> NSManagedObjectContext?{
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            //self.alert(WithTitle: errorMsg, andMessage: UserInfoMsg)
            return nil
        }
        return appDelegate.persistentContainer.viewContext
    }
    
        // MARK : Méthodes alert
    
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
    
        // MARK : Méthodes Base de données
    
        // Supprime le document donné en paramètre de la base de données
    func deleteDoc(messageWithIndex indexPath: IndexPath){
        let doc = self.docsFetched.object(at: indexPath)
        if DocumentSet.deleteDocument(doc: doc) {alert(WithTitle: "OK", andMessage: "")} else {alert(WithTitle: "Impossible de supprimer ce document", andMessage: "")}
     
    }
    
    // MARK: - NSFetchResultController delegate protocol
    
    /// Start the update of a fetch result
    ///
    /// - Parameter controller: fetchresultcontroller
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.docTable.beginUpdates()
    }
    
    /// End the update of a fetch result
    ///
    /// - Parameter controller: fetchresultcontroller
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.docTable.endUpdates()
        self.docTable.reloadData()
    }
    
    /// Control the update of the fetch result
    ///
    /// - Parameters:
    ///   - controller: fetchresultcontroller
    ///   - anObject: object type
    ///   - indexPath: indexpath of the object
    ///   - type: type of modification
    ///   - newIndexPath: if indexpath change
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type{
        case .delete:
            if let indexPath = indexPath{
                self.docTable.deleteRows(at: [indexPath], with: .automatic)
            }
        case .insert:
            if let newIndexPath = newIndexPath{
                self.docTable.insertRows(at: [newIndexPath], with: .fade)
            }
        default:
            break
        }
    }

    
}
