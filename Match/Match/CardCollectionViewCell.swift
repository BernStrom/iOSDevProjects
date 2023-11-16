//
//  CardCollectionViewCell.swift
//  Match
//
//  Created by Bern N on 11/16/23.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var frontImageView: UIImageView!
    
    @IBOutlet weak var backImageView: UIImageView!
    
    var card: Card?
    
    func configureCell(card: Card) {
        self.card = card
        
        frontImageView.image = UIImage(named: card.imageName)
        
        if card.isMatched == true {
            backImageView.alpha = 0
            frontImageView.alpha = 0
            return
        } else {
            backImageView.alpha = 1
            frontImageView.alpha = 1
        }
        
        // Set the flipped state of the card cell by checking its status
        if card.isFlipped == true {
            // Show the front card image view
            flipUp(speed: 0)
        } else {
            // Show the back card image view
            flipDown(speed: 0, delay: 0)
        }
    }
    
    func flipUp(speed: TimeInterval = 0.3) {
        // Flip up animation
        UIView.transition(
            from: backImageView,
            to: frontImageView,
            duration: speed,
            options: [.showHideTransitionViews, .transitionFlipFromLeft]
        )
        
        // Set the card flipped state
        card?.isFlipped = true
    }
    
    func flipDown(speed: TimeInterval = 0.3, delay: TimeInterval = 0.5) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delay) {
            // Flip down animation
            UIView.transition(
                from: self.frontImageView,
                to: self.backImageView,
                duration: speed,
                options: [.showHideTransitionViews, .transitionFlipFromRight]
            )
        }
        
        // Set the card flipped state
        card?.isFlipped = false
    }
    
    func remove() {
        // Make the card image views invisible
        backImageView.alpha = 0
        
        UIView.animate(withDuration: 0.3, delay: 0.5, options: .curveEaseOut) {
            self.frontImageView.alpha = 0
        }
    }
    
}
