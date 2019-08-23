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
//        imageUser.layer.borderWidth = 1
//        imageUser.layer.masksToBounds = false
//        imageUser.layer.borderColor = UIColor.black.cgColor
        imageUser.layer.cornerRadius = imageUser.frame.height/2
//        imageUser.clipsToBounds = true
    }

    func setupCellUser(name: String) {
        nameUser.text = name
        let url = URL(string: UserDefaults.standard.string(forKey: "FotoFacebook")!)
        imageUser.sd_setImage(with: url, completed: nil)
    }
    
}
