//
//  ViewController.swift
//  Quizzler
//
//  Created by Bern N on 11/18/23.
//

import UIKit

class ViewController: UIViewController, QuizProtocol, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    var model = QuizModel()
    var questions = [Question]()
    var currentQuestionIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        model.delegate = self
        model.getQuestions()
    }
    
    // MARK: - QuizProtocol Methods
    
    func questionsRetrieved(_ questions: [Question]) {
        self.questions = questions
        
        tableView.reloadData()
    }
    
    // MARK: - UITableView Delegate Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Check questions array actually contains at least 1 question
        guard questions.count > 0 else {
            return 0
        }
        
        let currentQuestion = questions[currentQuestionIndex]
        
        if currentQuestion.answers != nil {
            return currentQuestion.answers!.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AnswerCell", for: indexPath)
        let label = cell.viewWithTag(1) as? UILabel
        
        if label != nil {
            // TODO: Set the answer text for the label
        }
        
        return cell
    }

}
