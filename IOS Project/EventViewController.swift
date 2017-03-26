//
//  EventViewController.swift
//  IOS Project
//
//  Created by bou kisrane on 25/03/2017.
//  Copyright © 2017 leobaptiste. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class EventViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource{

    //MARK: Variables de EventViewController

    
    @IBOutlet weak var tableEvents: UITableView!
    
    @IBOutlet weak var choixGroupe: UIPickerView!
    
    var pickerData: [String] = []
    var groupe: GroupeSet = GroupeSet()
    
    fileprivate lazy var eventsFetched : NSFetchedResultsController<Evenement> = {
        let g: GroupeSet = GroupeSet()
        let request : NSFetchRequest<Evenement> = Evenement.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key:#keyPath(Evenement.dateE), ascending:true)]
        request.predicate = NSPredicate(format: "(dateE >= %@) && (concerneG = %@)", DateHelper.currentDate() as CVarArg, g.groupeCorrespondant(name: "Tous")!)
        let fetchResultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataManager.context, sectionNameKeyPath:nil, cacheName:nil)
        fetchResultController.delegate = self
        return fetchResultController
    }()
    
    //MARK: Methodes de EventViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        do{
            try self.eventsFetched.performFetch()
            
        }
        catch let error as NSError{
            self.alertError(errorEvt: "\(error)", userInfo: "\(error.userInfo)")
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
    
    
    //MARK: Méthodes tableView
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableEvents.dequeueReusableCell(withIdentifier: "evtCell", for: indexPath)
            as! CellViewEventList
        let evt = self.eventsFetched.object(at: indexPath)
        cell.dateEvent.text = DateHelper.convertDateToString(d: evt.dateE as! Date)
        cell.nomEvent.text = evt.nomE
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = self.eventsFetched.sections?[section] else {
            fatalError("Arrrgh")
        }
        return section.numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    

    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //MARK: Méthodes pickerView
    
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
        self.refreshEvt()
        
        
    }
    
    //MARK: Autre Méthodes
    
    func refreshEvt(){
        let evtsUpdate : NSFetchedResultsController<Evenement> = {
            let request : NSFetchRequest<Evenement> = Evenement.fetchRequest()
            request.sortDescriptors = [NSSortDescriptor(key:#keyPath(Evenement.dateE), ascending:true)]
            request.predicate = NSPredicate(format: "(dateE >= %@) && (concerneG = %@)", DateHelper.currentDate() as CVarArg, GroupeSet.groupeChoisi!)
            let fetchResultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataManager.context, sectionNameKeyPath:nil, cacheName:nil)
            fetchResultController.delegate = self
            return fetchResultController
        }()
        
        self.eventsFetched = evtsUpdate
        do{
            try eventsFetched.performFetch()
        }
            
        catch let error as NSError{
            fatalError("failed to get events\(error)")
        }
        self.tableEvents.reloadData()
    }
    
    func alertError(errorEvt error : String, userInfo user: String = "")
    {
        let alert = UIAlertController(title: error, message: user, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    
    // MARK: - NSFetchResultController delegate protocol
    
    /// Start the update of a fetch result
    ///
    /// - Parameter controller: fetchresultcontroller
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableEvents.beginUpdates()
    }
    
    /// End the update of a fetch result
    ///
    /// - Parameter controller: fetchresultcontroller
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableEvents.endUpdates()
        self.tableEvents.reloadData()
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
                self.tableEvents.deleteRows(at: [indexPath], with: .automatic)
            }
        case .insert:
            if let newIndexPath = newIndexPath{
                self.tableEvents.insertRows(at: [newIndexPath], with: .fade)
            }
        default:
            break
        }
    }
    
    
}
