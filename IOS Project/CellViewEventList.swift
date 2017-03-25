//
//  CellViewEventList.swift
//  IOS Project
//
//  Created by bou kisrane on 25/03/2017.
//  Copyright © 2017 leobaptiste. All rights reserved.
//

import Foundation
import UIKit

class CellViewEventList: UITableViewCell {

    @IBOutlet weak var dateEvent: UILabel!
    @IBOutlet weak var nomEvent: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
