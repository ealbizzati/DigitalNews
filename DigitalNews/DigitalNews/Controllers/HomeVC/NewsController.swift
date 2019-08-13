//
//  HomeController.swift
//  DigitalNews
//
//  Created by Giuliano Accorsi on 06/08/19.
//  Copyright © 2019 Giuliano Accorsi. All rights reserved.
//

import Foundation

protocol NewsControllerDelegate: class {
    func didFinishRequest()
    func finishRefresh()
}


class NewsController {
    
    var arrayNews: [Article] = []
    var delegate: NewsControllerDelegate?
    var fetchMore: Bool = true
    var indexPageRequest: Int = 2
    
    func getNews() {
        if fetchMore {
            ApiManager().getNews { (newsArray, success) in
                if success {
                    if let arraySuccess = newsArray {
                        self.arrayNews = arraySuccess
                        self.delegate?.finishRefresh()
                        
                    }
                }
            }
        }
    }
    
    func loadMoreNews() {
        if fetchMore {
            self.fetchMore = false
            ApiManager().loadMoreNews(page: self.indexPageRequest) { (arrayNews, success) in
                if success {
                    if let array = arrayNews {
                        self.arrayNews.append(contentsOf: array)
                        self.indexPageRequest += 1
                        self.delegate?.didFinishRequest()
                    }
                }else {
                }
                self.fetchMore = true
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
