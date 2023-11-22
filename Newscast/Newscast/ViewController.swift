//
//  ViewController.swift
//  Newscast
//
//  Created by Bern N on 11/21/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var model = ArticleModel()
    var articles = [Article]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        model.delegate = self
        model.getArticles()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the index of the article the user selected
        let indexPath = tableView.indexPathForSelectedRow
        
        guard indexPath != nil else {
            return
        }
        
        // Get the article the user tapped on
        let article = articles[indexPath!.row]
        
        // Get a reference to the detail view controller
        let detailVC = segue.destination as! DetailViewController
        
        // Pass the article URL to the detail view controller
        detailVC.articleUrl = article.url!
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - UITableView Protocol Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as! ArticleCell
        
        let article = articles[indexPath.row]
        
        // Customize table cell
        cell.displayArticle(article)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToDetail", sender: self)
    }
    
}

extension ViewController: ArticleModelProtocol {
    
    // MARK: - ArticleModel Protocol Methods
    
    func articlesRetrieved(_ articles: [Article]) {
        self.articles = articles
        
        // Refresh the tableView to populate it with the news articles data
        tableView.reloadData()
    }
    
}
