//
//  APIManager.swift
//  DigitalNews
//
//  Created by Giuliano Accorsi on 23/07/19.
//  Copyright © 2019 Giuliano Accorsi. All rights reserved.
//

import Foundation
import Alamofire

class ApiManager {
    typealias completion <T> = (_ result: T, _ failure: Bool) -> Void
    
    
    func searchNews(word: String, page: Int, completion: @escaping completion<[Article]?>) {
        let url = API.baseURL + API.everything
        let parameters:Parameters  = ["q":word,
                                      "apiKey":API.apiKey,
                                      "page": page,
                                      "language":"pt"]
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON { (response) in
            if response.response?.statusCode == 200 {
                print("Deu Certo ApiManager - getNews()\n\(String(describing: response.result.value))")
                guard let data = response.data else {
                    completion(nil,false)
                    return
                }
                do {
                    let result = try JSONDecoder().decode(NewsAPI.self, from: data)
                    completion(result.articles,true)
                    return
                }catch {
                    print("Error - JSONDecoder() - ApiManager - searchNews()")
                    completion(nil,false)
                    return
                }
            }else {
                print("Não deu 200 :c - ApiManager - searchNews()")
                completion(nil,false)
                return
            }
        }
        
    }
    
    func getNews(completion: @escaping completion<[Article]?>) {

        let url = API.baseURL + API.topheadlines
        let parameters: Parameters = ["country":UserDefaults.standard.string(forKey: TypeUserSettings.isoCountry.rawValue) ?? "br",
                                      "page":1,
                                      "apiKey":API.apiKey,
                                      "category":UserDefaults.standard.string(forKey: TypeUserSettings.category.rawValue) ?? "general"]
        
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON { (response) in
            if response.response?.statusCode == 200 {
                print("Deu Certo ApiManager - getNews()\n\(String(describing: response.result.value))")
                guard let data = response.data else {
                    completion(nil,false)
                    return
                }
                do {
                    let result = try JSONDecoder().decode(NewsAPI.self, from: data)
                    completion(result.articles,true)
                    return
                }catch {
                    print("Error - JSONDecoder() - ApiManager - getNews()")
                    completion(nil,false)
                    return
                }
            }else {
                print("Não deu 200 :c - ApiManager - getNews()")
                completion(nil,false)
                return
            }
        }
    }
    
    
    func loadMoreNews(page: Int, completion: @escaping completion<[Article]?>) {
        let url = API.baseURL + API.topheadlines
        let parameters: Parameters = ["country":UserDefaults.standard.string(forKey: TypeUserSettings.isoCountry.rawValue) ?? "br",
                                      "page":page,
                                      "apiKey":API.apiKey,
                                      "category":UserDefaults.standard.string(forKey: TypeUserSettings.category.rawValue) ?? "general"]
        
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON { (response) in
            if response.response?.statusCode == 200 {
                print("Deu Certo ApiManager - loadMoreNews()\n\(String(describing: response.result.value))")
                guard let data = response.data else {
                    completion(nil,false)
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(NewsAPI.self, from: data)
                    completion(result.articles, true)
                    return
                }catch {
                    print("Error - JSONDecoder() - ApiManager - loadMoreNews()")
                    completion(nil,false)
                    return
                }
            }else {
                print("Não deu 200 :c - APIManager - loadMoreNews()")
                completion(nil,false)
                return
            }
        }
    }
}

