//
//  ActuViewCellTableViewCell.swift
//  IOS Project
//
//  Created by Baptiste VAUTRIN on 13/02/2017.
//  Copyright © 2017 leobaptiste. All rights reserved.
//

import UIKit

class ActuViewCellTableViewCell: UITableViewCell {
    @IBOutlet weak var ObjetActu: UILabel!
    @IBOutlet weak var ContenuActu: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
