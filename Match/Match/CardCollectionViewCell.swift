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
        
        // Reset the flipped state of the card cell by checking its status
        if card.isFlipped == true {
            // Show the front card image view
            flipUp(speed: 0)
        } else {
            // Show the back card image view
            flipDown(speed: 0)
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
    
    func flipDown(speed: TimeInterval = 0.3) {
        // Flip down animation
        UIView.transition(
            from: frontImageView,
            to: backImageView,
            duration: speed,
            options: [.showHideTransitionViews, .transitionFlipFromRight]
        )
        
        // Set the card flipped state
        card?.isFlipped = false
    }
    
}
