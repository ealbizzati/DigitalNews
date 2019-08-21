//
//  DetailVC.swift
//  DigitalNews
//
//  Created by Giuliano Accorsi on 07/08/19.
//  Copyright © 2019 Giuliano Accorsi. All rights reserved.
//

import UIKit
import WebKit


class DetailVC: UIViewController {
    @IBOutlet weak var webNew: WKWebView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    
    var article: String?
    var saved: String?
    
    
    override func viewDidLoad() {
        webNew.layer.cornerRadius = 30
        webNew.layer.masksToBounds = true
        
        
    }
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if Reachability.isConnectedToNetwork(){
            print("Internet Connection Available!")
            if let urlString = article {
                let url = URL(string: urlString)
                let request = URLRequest(url: url!)
                webNew.allowsBackForwardNavigationGestures = true
                webNew.allowsLinkPreview = false   //Padrão true
                webNew.navigationDelegate = self
                webNew.uiDelegate = self
                webNew.load(request)
            }
        }else{
            print("Internet Connection not Available!")
            if let urlSaved = saved {
                webNew.loadHTMLString(urlSaved, baseURL: nil)
            }
        }
        
        
        
        
        
    }
}


extension DetailVC: WKNavigationDelegate, WKUIDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webNew.evaluateJavaScript("alert('Terminou de carregar')") { (result, error) in
            print(result ?? "")
        }
        spinner.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        completionHandler()
    }
    
}
