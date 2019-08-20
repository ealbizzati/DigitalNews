//
//  FavoriteSingleton.swift
//  DigitalNews
//
//  Created by Giuliano Accorsi on 20/08/19.
//  Copyright © 2019 Giuliano Accorsi. All rights reserved.
//

import Foundation
class FavoriteDataProvider {
    static let shared = FavoriteDataProvider()
    static var arraySaved:[NewsSaved] = []
    static let dataManager = DataManager()
    
    static func loadAllNewsSaved() {
        dataManager.loadArrayNews { (arrayNewsSaved) in
            if let arrayNewsCoreData = arrayNewsSaved {
                arraySaved.append(contentsOf: arrayNewsCoreData)
            }
        }
    }
    
   static func registerNewsSaved(article: Article, completion: (Bool)-> Void) {
        dataManager.registerNews(article: article, htmlString: htmlToString(article: article)) { (success) in
            if success {
                loadAllNewsSaved()
                completion(true)
                print("Deu bom ao registrar")
            }else {
                completion(false)
            }
        }
    }
    
   static func htmlToString(article: Article) -> String {
        if let url = URL(string: article.url ?? "") {
            do {
                let contents = try String(contentsOf: url)
                print("Converteu de HTML Pra String")
                return contents
            } catch {
                // contents could not be loaded
            }
        } else {
            // the URL was bad!
        }
        return ""
    }
    
    static func deleteNewsSaved(index: Int, completion: (Bool) -> Void) {
        dataManager.deleteNews(id: arraySaved[index].objectID) { (success) in
            if success {
                loadAllNewsSaved()
                print("Deu Bom ao Deleter")
            }
        }
    }
    
    
    static func getArrayCount() -> Int {
        return arraySaved.count
    }
    
    static func getArticle(index: Int) -> NewsSaved {
        return arraySaved[index]
    }
    
    static func cleanArray() {
        arraySaved = []
    }
    
}


