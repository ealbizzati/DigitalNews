//
//  CountryLanguageCell.swift
//  DigitalNews
//
//  Created by Giuliano Accorsi on 14/08/19.
//  Copyright © 2019 Giuliano Accorsi. All rights reserved.
//

import UIKit

class ReusableCell: UITableViewCell {

    @IBOutlet weak var labelTexto: UILabel!
    @IBOutlet weak var labelTextoUserDefault: UILabel!
    @IBOutlet weak var imageCell: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setupCell(labelTexto: String, labelUserDefault: String, image: String) {
        self.imageCell.image = UIImage(named: image)
        self.labelTexto.text = labelTexto
        self.labelTextoUserDefault.text = labelUserDefault
    }
    
    func setupCellWithoutLabel(stringTexto: String, image: String) {
        self.imageCell.image = UIImage(named: image)
        labelTextoUserDefault.text = ""
        self.labelTexto.text = stringTexto
        
    }

    
}