//
//  ViewController.swift
//  Quizzler
//
//  Created by Bern N on 11/18/23.
//

import UIKit

class ViewController: UIViewController, QuizProtocol {
    
    var model = QuizModel()
    var questions = [Question]()
    var currentQuestionIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        model.delegate = self
        model.getQuestions()
    }
    
    // MARK: - QuizProtocol Methods
    
    func questionsRetrieved(_ question: [Question]) {
        print("Questions retrieved from model.")
    }

}
