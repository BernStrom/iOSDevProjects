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
        // Fetch quiz questions
        getLocalJsonData()
    }
    
    func getLocalJsonData() {
        let path = Bundle.main.path(forResource: "QuestionData", ofType: "json")
        
        guard path != nil else {
            print("JSON data file not found.")
            return
        }
        
        let url = URL(filePath: path!)
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let questionsList = try decoder.decode([Question].self, from: data)
            
            delegate?.questionsRetrieved(questionsList)
        } catch {
            print("Couldn't read data from JSON file at given file path URL.")
        }
        
    }
    
    func getRemoteJsonData() {
        
    }
    
}
