//
//  ContactTableViewCell.swift
//  ReadContacts
//
//  Created by MAC on 31/7/20.
//  Copyright © 2020 Arif Hossen. All rights reserved.
//

import UIKit

class ContactTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameOutlet: UILabel!
    
    @IBOutlet weak var phoneOutlet: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
