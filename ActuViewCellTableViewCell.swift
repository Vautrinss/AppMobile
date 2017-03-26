//
//  ActuViewCellTableViewCell.swift
//  IOS Project
//
//  Created by Baptiste VAUTRIN on 13/02/2017.
//  Copyright © 2017 leobaptiste. All rights reserved.
//

import UIKit

class ActuViewCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var auteurActu: UILabel!
    @IBOutlet weak var objetActu: UILabel!
    
    @IBOutlet weak var contenuActu: UILabel!
    
    @IBOutlet weak var dateActu: UILabel!
    @IBOutlet weak var imageActu: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
