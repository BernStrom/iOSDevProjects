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
    
    var firstFlippedCardIndex: IndexPath?

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
        // Create a card cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCollectionViewCell
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        // Configure the card cells state based on the represented Card object properties
        
        let cardCell = cell as? CardCollectionViewCell
        
        // Get the card from the card list
        let card = cardsList[indexPath.row]
        
        // Configure the card cell
        cardCell?.configureCell(card: card)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Get a reference to the card cell that was tapped
        let cell = collectionView.cellForItem(at: indexPath) as? CardCollectionViewCell
        
        // Check the card flipped and match state to determine how to flip it
        if cell?.card?.isFlipped == false && cell?.card?.isMatched == false {
            // Flips the front of the card facing up
            cell?.flipUp()
            
            // Check if this is the first card flipped over
            if firstFlippedCardIndex == nil {
                // First card flipped over
                firstFlippedCardIndex = indexPath
            } else {
                // Second card flipped over and run card comparison logic
                checkCardsForMatch(indexPath)
            }
        }
    }
    
    // MARK: - Game Logic Methods
    
    func checkCardsForMatch(_ secondFlippedCardIndex: IndexPath) {
        // Get the selected two card objects indices
        let cardOne = cardsList[firstFlippedCardIndex!.row]
        let cardTwo = cardsList[secondFlippedCardIndex.row]
        
        // Get the two collection view cell objects that represent card one and two
        let cardOneCell = collectionView.cellForItem(at: firstFlippedCardIndex!) as? CardCollectionViewCell
        let cardTwoCell = collectionView.cellForItem(at: secondFlippedCardIndex) as? CardCollectionViewCell
        
        // Compare the two cards flipped over to check if they match
        if cardOne.imageName == cardTwo.imageName {
            // Set the match state
            cardOne.isMatched = true
            cardTwo.isMatched = true
            
            // Remove the matched cards 
            cardOneCell?.remove()
            cardTwoCell?.remove()
        } else {
            // Set the card flipped state
            cardOne.isFlipped = false
            cardTwo.isFlipped = false
            
            // Flip the un-matched cards back down
            cardOneCell?.flipDown()
            cardTwoCell?.flipDown()
        }
        
        // Reset the firstFlippedCardIndex property
        firstFlippedCardIndex = nil
    }

}
