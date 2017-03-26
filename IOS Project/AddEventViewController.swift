//
//  AddEventViewController.swift
//  IOS Project
//
//  Created by bou kisrane on 25/03/2017.
//  Copyright © 2017 leobaptiste. All rights reserved.
//

import Foundation
import UIKit
import EventKit
import CoreData


class AddEventViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    
    //MARK: Variables de AddEventViewController

    var calendar: EKCalendar!
    
    
    @IBOutlet weak var nomEvt: UITextField!
    @IBOutlet weak var dateEvt: UIDatePicker!
    
    @IBOutlet weak var groupe: UIPickerView!
    var pickerData: [String] = []
    var g: GroupeSet = GroupeSet()
    var groupeChoisi: String = ""

    
    //MARK: Méthodes de AddEventViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Session.userConnected?.statutP == 1
        {
            self.pickerData = g.listGroupsNames(list: g.listGroupe()!)
        }
        else{
            self.pickerData = g.listGroupsNames(list: g.listGroupe(personne: Session.userConnected!)!)
        }
        
        // Connect data:
        self.groupe.delegate = self
        self.groupe.dataSource = self
    }
    
    //MARK: Méthodes pickerView
    
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
    
    //MARK: méthodes Date pickerView
    
    
    func initialDatePickerValue() -> Date {
        let calendarUnitFlags: NSCalendar.Unit = [.year, .month, .day, .hour, .minute, .second]
        
        var dateComponents = (Calendar.current as NSCalendar).components(calendarUnitFlags, from: Date())
        
        dateComponents.hour = 0
        dateComponents.minute = 0
        dateComponents.second = 0
        
        return Calendar.current.date(from: dateComponents)!
    }
    
    //MARK: Autres méthodes
    
    @IBAction func btnRetour(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func alertError(errorEvt error : String, userInfo user: String = "")
    {
        let alert = UIAlertController(title: error, message: user, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    
    @IBAction func btnAjouter(_ sender: Any) {

        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else
        {
            return
        }
        let context = appDelegate.persistentContainer.viewContext
        if(nomEvt.text != "") {
        let evt = Evenement(context: context)
        evt.nomE = nomEvt.text
        evt.dateE = dateEvt.date as NSDate?
        evt.auteurEvt = Session.userConnected
        if self.groupeChoisi == "" {
            evt.concerneG = g.groupeCorrespondant(name: pickerData[groupe.selectedRow(inComponent: 0)])}
        else { evt.concerneG = g.groupeCorrespondant(name: groupeChoisi)}
       
        
        if EvenementSet.addEvenement(evenement: evt){
            self.dismiss(animated: true, completion: nil)}
        else {alertError(errorEvt: "Impossible d'ajouter l'evenement", userInfo: "no")}
        }
    }
    
    
    
}
