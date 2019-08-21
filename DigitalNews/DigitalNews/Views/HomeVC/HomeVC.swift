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
    
    var controller: NewsController?
    var refreshControl:UIRefreshControl = UIRefreshControl()
    
    var viewController: FavoriteVC?=nil
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to Refresh")
        self.refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        
        self.spinner.startAnimating()
        self.spinner.isHidden = false
        
        
        controller = NewsController()
        controller?.delegate = self
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "NewsCell", bundle: nil), forCellReuseIdentifier: "NewsCell")
        tableView.addSubview(refreshControl )
        
        controller?.getNews()
        
    }
    
    @objc func refresh(sender: AnyObject) {
        self.controller?.getNews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(self.valueChanged), name: Notification.Name("UserChangedValue"), object: nil)
    }
    
    @objc func valueChanged() {
        self.tableView.isHidden = true
        self.spinner.startAnimating()
        self.spinner.isHidden = false
        controller?.getNews()
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
        viewController.article = controller?.getArticle(index: indexPath.section).url
        tableView.deselectRow(at: indexPath, animated: true)
        self.present(viewController, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let tagertContentOffSet = (tableView.contentSize.height - tableView.frame.height)
        if scrollView.contentOffset.y * 2 > tagertContentOffSet {
            controller?.loadMoreNews()
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let favoritarSwipe = UIContextualAction(style: .normal, title: "Favoritar") { [weak self](action, view, completionHandler) in
            guard let self = self else {
                return completionHandler(false)
            }
            
            FavoriteDataProvider.shared.registerNewsSaved(article: self.controller?.getArticle(index: indexPath.section) ?? Article(source: Source(id: "", name: ""), author: "", title: "", articleDescription: "", url: "", urlToImage: "", publishedAt: "", content: ""), completion: { (success) in
                if success {
                    print("Deu bom ao favoritar")
                }
            })
            completionHandler(true)
        }
        favoritarSwipe.backgroundColor = .orange
        favoritarSwipe.image = UIImage(named: "like")
        return UISwipeActionsConfiguration(actions: [favoritarSwipe])
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let ShareSwipe = UIContextualAction(style: .normal, title: "Compartilhar") { [weak self](action, view, completionHandler) in
            guard let self = self else {
                return completionHandler(false)
            }
            // Função Compartilhar
            let activtyController = UIActivityViewController(activityItems: [self.controller?.getArticle(index: indexPath.section).url as Any], applicationActivities: nil)
            self.present(activtyController, animated: true)
            completionHandler(true)
        }
        ShareSwipe.backgroundColor = UIColor(red: 0.259, green: 0.405, blue: 0.699, alpha: 1.0)
        ShareSwipe.image = UIImage(named: "share")
        return UISwipeActionsConfiguration(actions: [ShareSwipe])
    }

}

extension HomeVC: NewsControllerDelegate {
    func didFinishRequest() {
        self.tableView.reloadData()
    }
    
    func finishRefresh() {
        self.spinner.stopAnimating()
        self.spinner.isHidden = true
        self.refreshControl.endRefreshing()
        self.tableView.reloadData()
        self.tableView.isHidden = false
        
    }
    
    
    
}

