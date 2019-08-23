//
//  SearchVC.swift
//  DigitalNews
//
//  Created by Giuliano Accorsi on 06/08/19.
//  Copyright © 2019 Giuliano Accorsi. All rights reserved.
//

import UIKit

class SearchVC: BaseViewController {
    
    var controller: SearchController?
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.isHidden = true
        controller = SearchController()
        
        searchBar.delegate = self
        controller?.delegate = self
        
        
        
    }
}

extension SearchVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return controller?.getArrayCount() ?? 0
        }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {return UITableViewCell()}
        cell.textLabel?.text = controller?.getArticle(index: indexPath.row).title
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard.init(name: "Detail", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "DetailVC") as? DetailVC else {return}
        viewController.saved = controller?.getArticle(index: indexPath.row).url
        viewController.article = controller?.getArticle(index: indexPath.row).url
        tableView.deselectRow(at: indexPath, animated: true)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let tagertContentOffSet = (tableView.contentSize.height - tableView.frame.height)
        if scrollView.contentOffset.y > tagertContentOffSet {
            controller?.loadMoreNews()
        }
    }
    
}

extension SearchVC: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.startAnimating()
        controller?.searchNews(word: searchBar.text ?? "")
        searchBar.resignFirstResponder()
    }
    
    
}

extension SearchVC: searchNewsControllerDelegate {
    func didFinishRequest() {
        self.tableView.isHidden = false
        self.tableView.reloadData()
        self.stopAnimating()
    }
    
    func finishRefresh() {
        self.tableView.isHidden = false
        self.tableView.reloadData()
        self.stopAnimating()
        
    }
    
    
}



