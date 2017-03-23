import UIKit
import CoreData

class FilActuView: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate{
    

    
    
    
    
    fileprivate lazy var documentsFetched : NSFetchedResultsController<Document> = {
        let request : NSFetchRequest<Document> = Document.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key:#keyPath(Message.nomDoc), ascending:true)]
        //request.predicate = NSPredicate(format: "adresser == %@", GroupeSet.groupeChoisi!)
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
        
        if Session.userConnected?.statutP < 4
        {
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
    
       
    
}
