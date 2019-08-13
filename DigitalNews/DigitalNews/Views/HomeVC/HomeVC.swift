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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let tagertContentOffSet = (tableView.contentSize.height - tableView.frame.height)
        print(scrollView.contentOffset.y)
        print(tagertContentOffSet)
        if scrollView.contentOffset.y * 2 > tagertContentOffSet {
            controller?.loadMoreNews()
        }
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

