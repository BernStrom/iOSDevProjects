//
//  ViewController.swift
//  Match
//
//  Created by Bern N on 11/16/23.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var timerLabel: UILabel!
    
    let model = CardModel()
    var cardsList = [Card]()
    
    var timer: Timer?
    var milliseconds: Int = 30 * 1000
    
    var firstFlippedCardIndex: IndexPath?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardsList = model.getCards()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(timerFired), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: .common)
    }
    
    // MARK: - Timer Methods
    
    @objc func timerFired() {
        // Decrement the counter
        milliseconds -= 1
        
        // Update the timer label
        let seconds: Double = Double(milliseconds) / 1000.0
        timerLabel.text = String(format: "Time Remaining: %.2f", seconds)
        
        // Stop the timer if it reaches zero
        if milliseconds == 0 {
            timerLabel.textColor = UIColor.red
            timer?.invalidate()
            
            // Check if user cleared all card pairs
            checkForGameEnd()
        }
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
            
            // Check if the matched card was the last pair
            checkForGameEnd()
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
    
    func checkForGameEnd() {
        // Set the default user win state
        var hasWon = true
        
        for card in cardsList {
            // Check for any un-matched cards
            if card.isMatched == false {
                hasWon = false
                break
            }
        }
        
        if hasWon {
            // Stop the timer and show an alert popup to indicate user has won
            timer?.invalidate()
            showAlert(title: "Congratulations", message: "You've won the game! 🥳")
        } else {
            // Check first if there's any time left, if user hasn't won the game yet
            if milliseconds <= 0 {
                showAlert(title: "Time's Up", message: "Sorry, better luck next time! 😛")
            }
        }
    }
    
    func showAlert(title: String, message: String) {
        // Create an alert popup and dismiss action button
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Ok", style: .default)
        
        // Add an "Ok" button for the user to dismiss the alert popup
        alert.addAction(dismissAction)
        
        // Show the alert popup
        present(alert, animated: true)
    }

}
