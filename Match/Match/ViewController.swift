//
//  ViewController.swift
//  Match
//
//  Created by Bern N on 11/16/23.
//

import UIKit

class ViewController: UIViewController {
    
    let model = CardModel()
    var cardsList = [Card]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardsList = model.getCards()
    }

}
