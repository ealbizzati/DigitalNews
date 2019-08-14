//
//  LocalVC.swift
//  DigitalNews
//
//  Created by Giuliano Accorsi on 13/08/19.
//  Copyright © 2019 Giuliano Accorsi. All rights reserved.
//

import UIKit

class LocalVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var controller: UserController?
    override func viewDidLoad() {
        controller = UserController()
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        
        self.tableView.delegate = self
        self.tableView.dataSource = self

    }

}
extension LocalVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return controller?.numberOfRowsCountry() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell", for: indexPath)
        cell.textLabel?.text = controller?.loadCountry(index: indexPath.row)
        return cell
    }
    
    
    
    
}
