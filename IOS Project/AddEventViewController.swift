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


class AddEventViewController: UIViewController {

    var calendar: EKCalendar!
    
    
    @IBOutlet weak var nomEvt: UITextField!
    @IBOutlet weak var dateEvt: UIDatePicker!
    
    //var delegate: EventAddedDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.dateEvt.setDate(initialDatePickerValue(), animated: false)
    }
    
    func initialDatePickerValue() -> Date {
        let calendarUnitFlags: NSCalendar.Unit = [.year, .month, .day, .hour, .minute, .second]
        
        var dateComponents = (Calendar.current as NSCalendar).components(calendarUnitFlags, from: Date())
        
        dateComponents.hour = 0
        dateComponents.minute = 0
        dateComponents.second = 0
        
        return Calendar.current.date(from: dateComponents)!
    }
    
    
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
        
        let evt = Evenement(context: context)
        evt.nomE = nomEvt.text
        evt.dateE = dateEvt.date as NSDate?
        evt.auteurEvt = Session.userConnected
        if EvenementSet.addEvenement(evenement: evt){
            self.dismiss(animated: true, completion: nil)}
        else {alertError(errorEvt: "Impossible d'ajouter l'evenement", userInfo: "no")}
    }
    
    
    
}
