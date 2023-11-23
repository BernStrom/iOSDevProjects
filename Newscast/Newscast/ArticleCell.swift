//
//  ArticleCell.swift
//  Newscast
//
//  Created by Bern N on 11/22/23.
//

import UIKit

class ArticleCell: UITableViewCell {
    
    @IBOutlet weak var headlineLabel: UILabel!
    
    @IBOutlet weak var articleImageView: UIImageView!
    
    var articleToDisplay: Article?
    
    func displayArticle(_ article: Article) {
        // Reset the table cell contents before displaying the next article
        // Set initial table cell contents alpha values to 0 to prepare for animations
        headlineLabel.text = ""
        headlineLabel.alpha = 0
        articleImageView.image = nil
        articleImageView.alpha = 0
        
        articleToDisplay = article
        
        headlineLabel.text = articleToDisplay!.title
        
        // Animate the headline label with a fade effect into view
        UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseOut) {
            self.headlineLabel.alpha = 1
        }
        
        guard articleToDisplay!.urlToImage != nil else {
            return
        }
        
        // Get a reference to the article image URL
        let urlString = articleToDisplay!.urlToImage!
        
        // Check the CacheManager before downloading any image data
        if let imageData = CacheManager.retrievedData(urlString) {
            // Set the article image with the image data from the cache
            articleImageView.image = UIImage(data: imageData)
            
            // Animate the article image with a fade effect into view
            UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseOut) {
                self.articleImageView.alpha = 1
            }
            
            return
        }
        
        let url = URL(string: urlString)
        
        guard url != nil else {
            print("Couldn't create the URL object from the article image URL")
            return
        }
        
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: url!) { data, response, error in
            if error == nil && data != nil {
                // Save the data into cache
                CacheManager.savedData(urlString, data!)
                
                // Check if the image URL string matches the article image URL of the cell that is set to display
                if self.articleToDisplay!.urlToImage == urlString {
                    // Update the UI with article images on the main thread
                    DispatchQueue.main.async {
                        self.articleImageView.image = UIImage(data: data!)
                        
                        // Animate the article image with a fade effect into view
                        UIView.animate(withDuration: 0.6, delay: 0, options: .curveEaseOut) {
                            self.articleImageView.alpha = 1
                        }
                    }
                }
            }
        }
        
        dataTask.resume()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
