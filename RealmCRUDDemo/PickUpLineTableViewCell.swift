//
//  PickUpLineTableViewCell.swift
//  RealmCRUDDemo
//
//  Created by Asmita Borawake on 04/10/19.
//  Copyright © 2019 Asmita Borawake. All rights reserved.
//

import UIKit

class PickUpLineTableViewCell: UITableViewCell {

    @IBOutlet weak var pickuplineLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var scoreLbl: UILabel!
    
    func configureData(pickuplinedata : PickUpLine)
    {
        pickuplineLbl.text = pickuplinedata.line
        emailLbl.text = pickuplinedata.email
        scoreLbl.text = pickuplinedata.scoreString()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
