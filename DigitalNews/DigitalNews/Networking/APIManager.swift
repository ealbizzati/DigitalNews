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
    
    func getNews(completion: @escaping completion<[Article]?>) {
        let url = API.baseURL + API.topheadlines
        let parameters: Parameters = ["country":"br",
                                      "page":1,
                                      "apiKey":API.apiKey]
        
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
                }catch {
                    print("Error - JSONDecoder() - ApiManager - getNews()")
                    completion(nil,false)
                }
            }else {
                print("Não deu 200 :c - ApiManager = getNews()")
                completion(nil,false)
            }
        }
    }
}
