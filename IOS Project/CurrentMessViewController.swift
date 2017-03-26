//
//  currentMessViewController.swift
//  IOS Project
//
//  Created by bou kisrane on 26/03/2017.
//  Copyright © 2017 leobaptiste. All rights reserved.
//

import Foundation
import UIKit
import CoreData


class CurrentMessViewController: UIViewController {


    @IBOutlet weak var nomSel: UILabel!
    
    @IBOutlet weak var dateSel: UILabel!
    @IBOutlet weak var objSel: UILabel!
    
    @IBOutlet weak var contSel: UITextView!
    
    
    @IBAction func cancelBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
}
