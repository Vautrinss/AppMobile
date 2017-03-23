//
//  cellViewDocList.swift
//  IOS Project
//
//  Created by Leo PERNELLE on 23/03/2017.
//  Copyright © 2017 leobaptiste. All rights reserved.
//

import UIKit

class cellViewDocList: UITableViewCell {
    

    @IBOutlet weak var auteurDoc: UILabel!
    @IBOutlet weak var nomDoc: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    
}
