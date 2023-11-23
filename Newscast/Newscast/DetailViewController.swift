//
//  DetailViewController.swift
//  Newscast
//
//  Created by Bern N on 11/21/23.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var articleUrl: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.navigationDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Check that it contains an article URL
        if articleUrl != nil {
            let url = URL(string: articleUrl!)
            
            guard url != nil else {
                print("DetailViewController: - Couldn't create the URL object from the article URL path")
                return
            }
            
            let request = URLRequest(url: url!)
            
            // Start the spinner loading animation
            spinner.alpha = 1
            spinner.startAnimating()
            
            // Load the full article page into web view
            webView.load(request)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension DetailViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        // Stop the spinner loading animation and hide it from view
        spinner.stopAnimating()
        spinner.alpha = 0
    }
    
}
