//
//  QuizModel.swift
//  Quizzler
//
//  Created by Bern N on 11/18/23.
//

import Foundation

protocol QuizProtocol {
    func questionsRetrieved(_ question: [Question])
}

class QuizModel {
    
    var delegate: QuizProtocol?
    
    func getQuestions() {
        // TODO: Fetch the questions
        
        
        // Notify the delegate of the retrieved questions
        delegate?.questionsRetrieved([Question]())
    }
    
}
