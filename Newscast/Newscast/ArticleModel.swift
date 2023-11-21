//
//  ArticleModel.swift
//  Newscast
//
//  Created by Bern N on 11/21/23.
//

import Foundation

protocol ArticleModelProtocol {
    func articlesRetrieved(_ articles: [Article])
}

class ArticleModel {
    
    var delegate: ArticleModelProtocol?
    
    func getArticles() {
        
        
        delegate?.articlesRetrieved([Article]())
    }
    
}
