//
//  ViewController.swift
//  Newscast
//
//  Created by Bern N on 11/21/23.
//

import UIKit

class ViewController: UIViewController {
    
    var model = ArticleModel()
    var articles = [Article]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        model.delegate = self
        model.getArticles()
    }
    
}

extension ViewController: ArticleModelProtocol {
    
    // MARK: - Article Model Protocol Methods
    
    func articlesRetrieved(_ articles: [Article]) {
        self.articles = articles
    }
    
}
