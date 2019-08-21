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
        
        self.tableView.register(UINib(nibName: "FavoriteTableCell", bundle: nil), forCellReuseIdentifier: "FavoriteTableCell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    

    
    override func viewWillAppear(_ animated: Bool) {
        FavoriteDataProvider.shared.loadAllNewsSaved { (success) in
            if success {
                self.tableView.reloadData()
            }
        }
        
    }

}

extension FavoriteVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FavoriteDataProvider.shared.getArrayCount()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard.init(name: "Detail", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "DetailVC") as? DetailVC else {return}
        viewController.saved = FavoriteDataProvider.shared.getNewsSaved(index: indexPath.row)
        viewController.article = FavoriteDataProvider.shared.getFullArticle(index: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
        self.present(viewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteTableCell", for: indexPath) as? FavoriteTableCell else { return UITableViewCell()}
        
        cell.setupCell(news: (FavoriteDataProvider.shared.loadNewsSaved(index: indexPath.row)))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            FavoriteDataProvider.shared.deleteNewsSaved(index: indexPath.row) { (success) in
                if success {
                    FavoriteDataProvider.shared.loadAllNewsSaved(completion: { (success) in
                        if success {
                            self.tableView.reloadData()
                        }
                    })
                }
            }
        }
    }
    
    
}
