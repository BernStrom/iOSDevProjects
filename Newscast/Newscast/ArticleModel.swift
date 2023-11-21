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
        let apiKey = Bundle.main.infoDictionary?["API_KEY"] as? String
        
        guard apiKey != nil else {
            print("API key not found")
            return
        }
        
        let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=\(apiKey!)")
        
        guard url != nil else {
            print("Couldn't create the URL object from the URL path")
            return
        }
        
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: url!) { data, response, error in
            if error == nil && data != nil {
                do {
                    let decoder = JSONDecoder()
                    let articlesService = try decoder.decode(ArticleService.self, from: data!)
                    
                    // Use the main thread to notify the view controller to update the UI
                    DispatchQueue.main.async {
                        self.delegate?.articlesRetrieved(articlesService.articles!)
                    }
                } catch {
                    print("Couldn't read data from News API at given URL path")
                }
            }
        }
        
        dataTask.resume()
    }
    
}
