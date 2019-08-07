//
//  ViewController.swift
//  DigitalNews
//
//  Created by Giuliano Accorsi on 23/07/19.
//  Copyright © 2019 Giuliano Accorsi. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var controller: HomeController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        controller = HomeController()
        controller?.delegate = self
        
        controller?.loadNews()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "NewsCell", bundle: nil), forCellReuseIdentifier: "NewsCell")
        
    }


}

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return controller?.getArrayCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as? NewsCell else {
            return UITableViewCell()
        }
        cell.setupCell(article: (controller?.getArticle(index: indexPath.row))!)
        return cell
    }

    
}

extension HomeVC: HomeControllerDelegate {
    func loadNews() {
        self.tableView.reloadData()
    }
    
    
}

