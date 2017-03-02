//
//  DialogBoxHelper.swift
//  IOS Project
//
//  Created by Baptiste VAUTRIN on 02/03/2017.
//  Copyright © 2017 leobaptiste. All rights reserved.
//

import Foundation
import UIKit

class DialogBoxHelper{
    
    class func alert(view: UIViewController, WithTitle title:String, andMessage msg: String = "") {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title:"Ok", style: .default)
        alert.addAction(cancelAction)
        view.present(alert, animated: true)
        
    }
        class func alert(view: UIViewController, error: NSError){
            self.alert(view: view, WithTitle: "\(error)", andMessage: "\(error.userInfo)")
        }
    
    
}
