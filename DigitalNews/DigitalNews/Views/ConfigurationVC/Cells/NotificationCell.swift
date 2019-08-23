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
    @IBOutlet weak var imageCell: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func switchAction(_ sender: UISwitch) {
        if sender.isOn {
            UserDefaults.standard.set(true, forKey: "isDarkMode")
            NotificationCenter.default.post(name: .darkModeEnabled, object: nil)
        }else {
            UserDefaults.standard.set(false, forKey: "isDarkMode")
             NotificationCenter.default.post(name: .darkModeDisabled, object: nil)
        }
        
    }
    
    func setupNotifCell (labelTexto: String, image: String) {
        self.selectionStyle = .none
        self.labelTexto.text = labelTexto
        self.imageCell.image = UIImage(named: image)
    }
    
}
extension Notification.Name {
    static let darkModeEnabled = Notification.Name("com.DigitalNews.notifications.darkModeEnabled")
    static let darkModeDisabled = Notification.Name("com.DigitalNews.notifications.darkModeDisabled")
}
