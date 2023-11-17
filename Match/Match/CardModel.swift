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
        var generatedNumbers = [Int]()
        
        repeat {
            let randomNumber = Int.random(in: 1...13)
            
            if generatedNumbers.contains(randomNumber) == false {
                let cardOne = Card()
                let cardTwo = Card()
                
                cardOne.imageName = "card\(randomNumber)"
                cardTwo.imageName = "card\(randomNumber)"
                
                generatedCards += [cardOne, cardTwo]
                generatedNumbers.append(randomNumber)
            }
        } while (generatedCards.count < 16)
        
        generatedCards.shuffle()
        
        return generatedCards
    }
    
}
