//
//  QuizModel.swift
//  Quizzler
//
//  Created by Bern N on 11/18/23.
//

import Foundation

protocol QuizProtocol {
    func questionsRetrieved(_ questions: [Question])
}

class QuizModel {
    
    var delegate: QuizProtocol?
    
    func getQuestions() {
        // Fetch quiz questions
        getRemoteJsonData()
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
        let url = URL(string: "https://codewithchris.com/code/QuestionData.json")
        
        guard url != nil else {
            print("Couldn't create the URL object from the URL path")
            return
        }
        
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: url!) { data, response, error in
            if error == nil && data != nil {
                do {
                    let decoder = JSONDecoder()
                    let questionsList = try decoder.decode([Question].self, from: data!)
                    
                    // Use the main thread to notify the view controller to update the UI
                    DispatchQueue.main.async {
                        self.delegate?.questionsRetrieved(questionsList)
                    }
                } catch {
                    print("Couldn't read data from remote API at given URL path.")
                }
            }
        }
        
        dataTask.resume()
    }
    
}
