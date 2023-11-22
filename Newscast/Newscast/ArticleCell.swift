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
        // Reset the table cell before displaying the next article
        headlineLabel.text = ""
        articleImageView.image = nil
        
        articleToDisplay = article
        
        headlineLabel.text = articleToDisplay!.title
        
        guard articleToDisplay!.urlToImage != nil else {
//            print("Article image URL not found")
            return
        }
        
        // Get a reference to the article image URL
        let urlString = articleToDisplay!.urlToImage!
        
        let url = URL(string: urlString)
        
        guard url != nil else {
            print("Couldn't create the URL object from the article image URL")
            return
        }
        
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: url!) { data, response, error in
            if error == nil && data != nil {
                // Check if the image URL string matches the article image URL of the cell that is set to display
                if self.articleToDisplay!.urlToImage == urlString {
                    // Update the UI with article images on the main thread
                    DispatchQueue.main.async {
                        self.articleImageView.image = UIImage(data: data!)
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
