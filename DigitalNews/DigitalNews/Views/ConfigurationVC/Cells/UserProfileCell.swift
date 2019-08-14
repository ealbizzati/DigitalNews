//
//  UserProfileCell.swift
//  DigitalNews
//
//  Created by Giuliano Accorsi on 14/08/19.
//  Copyright © 2019 Giuliano Accorsi. All rights reserved.
//

import UIKit

class UserProfileCell: UITableViewCell {
    @IBOutlet weak var imageUser: UIImageView!
    @IBOutlet weak var nameUser: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageUser.layer.cornerRadius = 60
    }

    func setupCellUser(image: String, name: String) {
        nameUser.text = name
    }
    
}
