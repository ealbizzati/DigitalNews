
//
//  File.swift
//  DigitalNews
//
//  Created by paulopr4 on 17/08/19.
//  Copyright © 2019 Giuliano Accorsi. All rights reserved.
//

import Foundation

protocol searchNewsControllerDelegate: class {
    func didFinishRequest()
    func finishRefresh()
}


class SearchController {
    let apiManager  = ApiManager()
    var arrayNews: [Article] = []
    var delegate: searchNewsControllerDelegate?
    var fetchMore: Bool = true
    var indexPageRequest: Int = 2
   
    
    func searchNews(word: String, completion: @escaping ([Article]?, Bool) -> Void) {
        if fetchMore {
            apiManager.searchNews(word: word, page: indexPageRequest) { (newsArray, success) in
                if success {
                    if let arraySuccess = newsArray {
                        self.arrayNews = arraySuccess
                        self.delegate?.finishRefresh()
                        completion(self.arrayNews, true)
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
