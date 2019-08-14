//
//  NotificationCell.swift
//  DigitalNews
//
//  Created by Giuliano Accorsi on 14/08/19.
//  Copyright © 2019 Giuliano Accorsi. All rights reserved.
//

import UIKit

class NotificationCell: UITableViewCell {
    @IBOutlet weak var labelTexto: UILabel!
    @IBOutlet weak var switchButton: UISwitch!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func switchAction(_ sender: Any) {
    }
    
    func setupNotifCell (labelTexto: String) {
        self.labelTexto.text = labelTexto
    }
    
}
