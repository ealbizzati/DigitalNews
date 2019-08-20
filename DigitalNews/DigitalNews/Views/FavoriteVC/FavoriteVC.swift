//
//  FavoriteVC.swift
//  DigitalNews
//
//  Created by Giuliano Accorsi on 06/08/19.
//  Copyright © 2019 Giuliano Accorsi. All rights reserved.
//

import UIKit

class FavoriteVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var controller: FavoriteController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        controller = FavoriteController()
        controller?.loadAllNewsSaved()
        
        self.tableView.register(UINib(nibName: "FavoriteTableCell", bundle: nil), forCellReuseIdentifier: "FavoriteTableCell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.reloadData()
    }
    
    func addObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.valueChanged), name: Notification.Name("Favorite"), object: nil)  
        controller = FavoriteController()
    }
    
    @objc func valueChanged(notification: Notification) {
        if let dic = notification.userInfo as? [String:Article] {
            controller?.registerNewsSaved(article: dic["article"] ?? Article(source: Source(id: "", name: ""), author: "", title: "", articleDescription: "", url: "", urlToImage: "", publishedAt: "", content: ""), completion: { (success) in
                if success {
                    controller?.loadAllNewsSaved()
                }
            })
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }

}

extension FavoriteVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return controller?.getArrayCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteTableCell", for: indexPath) as? FavoriteTableCell else { return UITableViewCell()}
        
        cell.setupCell(news: (controller?.getArticle(index: indexPath.row))!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            controller?.deleteNewsSaved(index: indexPath.row, completion: { (success) in
                if success {
                    controller?.loadAllNewsSaved()
                    tableView.reloadData()
                }
            })
        }
    }
    
    
}
