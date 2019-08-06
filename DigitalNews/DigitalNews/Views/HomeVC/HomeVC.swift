//
//  ViewController.swift
//  DigitalNews
//
//  Created by Giuliano Accorsi on 23/07/19.
//  Copyright © 2019 Giuliano Accorsi. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let locale = Locale.current
        print(locale.regionCode?.lowercased())
        
        
        // Somente Teste
        let api = ApiManager()
        api.getNews { (sucess, error) in
            if error != nil {
                print("Deu Ruim")
            }else {
                print("UHUUUUUUUUu")
            }
        }
    }


}

