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
    func numberOfSections(in tableView: UITableView) -> Int {
        return controller?.getArrayCount() ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // somente 1 noticia por section
        return 1
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        return headerView
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as? NewsCell else {
            return UITableViewCell()
        }
        cell.setupCell(article: (controller?.getArticle(index: indexPath.section))!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewController = self.storyboard?.instantiateViewController(withIdentifier: "DetailVC") as? DetailVC else {return}
        viewController.article = controller?.getArticle(index: indexPath.section)
        tableView.deselectRow(at: indexPath, animated: true)
        self.present(viewController, animated: true)
    }
}

extension HomeVC: HomeControllerDelegate {
    func loadDetailNews() {
        
    }
    
    func loadNews() {
        self.tableView.reloadData()
    }
    
    
}

