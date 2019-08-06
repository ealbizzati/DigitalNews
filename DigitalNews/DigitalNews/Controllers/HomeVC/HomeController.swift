//
//  HomeController.swift
//  DigitalNews
//
//  Created by Giuliano Accorsi on 06/08/19.
//  Copyright © 2019 Giuliano Accorsi. All rights reserved.
//

import Foundation

protocol HomeControllerDelegate: class {
    func loadNews()
}


class HomeController {
    
    var arrayNews: [Article] = []
    var delegate: HomeControllerDelegate?
    
    func loadNews() {
        ApiManager().getNews { (newsArray, success) in
            if success {
                if let arraySuccess = newsArray {
                    self.arrayNews.append(contentsOf: arraySuccess)
                    self.delegate?.loadNews()
                    
                }
            }
        }
    }
    
    func getArrayCount() -> Int {
        return arrayNews.count
    }
    
    func getArticle(index: Int) -> Article {
        return arrayNews[index]
    }

}
