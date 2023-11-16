//
//  CardModel.swift
//  Match
//
//  Created by Bern N on 11/16/23.
//

import Foundation

class CardModel {
    
    func getCards() -> [Card] {
        var generatedCards = [Card]()
        
        repeat {
            let randomNumber = Int.random(in: 1...13)
            let cardOne = Card()
            let cardTwo = Card()
            
            cardOne.imageName = "card\(randomNumber)"
            cardTwo.imageName = "card\(randomNumber)"
            
            let hasDuplicateCardPairs = generatedCards.contains {
                $0.imageName == cardOne.imageName
            }
            
            if hasDuplicateCardPairs != true {
                generatedCards += [cardOne, cardTwo]
            }
        } while (generatedCards.count < 16)
        
        generatedCards.shuffle()
        
        return generatedCards
    }
    
}
