//
//  ConfigurationVC.swift
//  DigitalNews
//
//  Created by Giuliano Accorsi on 06/08/19.
//  Copyright © 2019 Giuliano Accorsi. All rights reserved.
//

import UIKit

enum Section: Int {
    case numberOfSection = 5
    case numberOfRowInSection = 1
}

enum TypeSection: Int {
    case Profile = 0
    case Notification = 1
    case Country = 2
    case Category = 3
    case Third = 4
    
}

class ConfigurationVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        
        self.tableView.register(UINib(nibName: "NotificationCell", bundle: nil), forCellReuseIdentifier: "NotificationCell")
        self.tableView.register(UINib(nibName: "ReusableCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
        self.tableView.register(UINib(nibName: "UserProfileCell", bundle: nil), forCellReuseIdentifier: "UserProfileCell")
    }

}

extension ConfigurationVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Section.numberOfSection.rawValue
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Section.numberOfRowInSection.rawValue
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 100
        }
        return 60
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case TypeSection.Profile.rawValue:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserProfileCell", for: indexPath) as? UserProfileCell else { return UITableViewCell()}
            cell.setupCellUser(image: "", name: "Giuliano Accorsi")
            return cell
        case TypeSection.Notification.rawValue:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationCell", for: indexPath) as? NotificationCell else { return UITableViewCell()}
            cell.setupNotifCell(labelTexto: "Notificação")
            return cell
        case TypeSection.Country.rawValue:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as? ReusableCell else {return UITableViewCell()}
            cell.setupCell(labelTexto: "País", labelUserDefault: "Brazil")
            return cell
        case TypeSection.Category.rawValue:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as? ReusableCell else {return UITableViewCell()}
            cell.setupCellWithoutLabel(stringTexto: "Categoria")
            return cell
        case TypeSection.Third.rawValue:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as? ReusableCell else {return UITableViewCell()}
            cell.setupCellWithoutLabel(stringTexto: "Reconhecimento de Terceiros")
            return cell
        default:
            return UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case TypeSection.Profile.rawValue:
            self.tableView.deselectRow(at: indexPath, animated: false)
        case TypeSection.Notification.rawValue:
            self.tableView.deselectRow(at: indexPath, animated: false)
        case TypeSection.Country.rawValue:
            self.tableView.deselectRow(at: indexPath, animated: false)
            guard let viewController = self.storyboard?.instantiateViewController(withIdentifier: "LocalVC") as? LocalVC else {return}
            self.navigationController?.pushViewController(viewController, animated: true)
        case TypeSection.Category.rawValue:
            self.tableView.deselectRow(at: indexPath, animated: false)
        case TypeSection.Third.rawValue:
            self.tableView.deselectRow(at: indexPath, animated: false)
        default:
            print("")
        }
    }
    
    
}
