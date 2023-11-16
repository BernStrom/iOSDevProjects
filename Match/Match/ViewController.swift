//
//  ViewController.swift
//  Match
//
//  Created by Bern N on 11/16/23.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let model = CardModel()
    var cardsList = [Card]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardsList = model.getCards()
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    // MARK: - Collection View Delegate Methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // Return number of cards
        return cardsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Get a card cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCollectionViewCell
        
        // Get the card from the card list
        let card = cardsList[indexPath.row]
        
        // Configure the card cell
        cell.configureCell(card: card)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Get a reference to the card cell that was tapped
        let cell = collectionView.cellForItem(at: indexPath) as? CardCollectionViewCell
        
        // Check the card flipped state to determine how to flip it
        if cell?.card?.isFlipped == false {
            // Flips the front of the card facing up
            cell?.flipUp()
        } else {
            // Flips the front of the card facing down
            cell?.flipDown()
        }
    }

}
