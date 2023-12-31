//
//  ViewController.swift
//  Quizzler
//
//  Created by Bern N on 11/18/23.
//

import UIKit

class ViewController: UIViewController, QuizProtocol, UITableViewDelegate, UITableViewDataSource, ResultViewControllerProtocol {
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var stackViewLeadingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var stackViewTrailingConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var rootStackView: UIStackView!
    
    var model = QuizModel()
    var questions = [Question]()
    var currentQuestionIndex = 0
    var numCorrect = 0
    
    var resultDialog: ResultViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultDialog = storyboard?.instantiateViewController(withIdentifier: "ResultVC") as? ResultViewController
        resultDialog?.modalPresentationStyle = .overCurrentContext
        resultDialog?.delegate = self
        
        tableView.dataSource = self
        tableView.delegate = self
        
        model.delegate = self
        model.getQuestions()
    }
    
    func slideInQuestion() {
        // Set the initial animation state
        stackViewTrailingConstraint.constant = -1000
        stackViewLeadingConstraint.constant = 1000
        rootStackView.alpha = 0
        view.layoutIfNeeded()
        
        // Slide in animation for the question
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut) {
            self.stackViewLeadingConstraint.constant = 0
            self.stackViewTrailingConstraint.constant = 0
            self.rootStackView.alpha = 1
            self.view.layoutIfNeeded()
        }
    }
    
    func slideOutQuestion() {
        // Set the initial animation state
        stackViewTrailingConstraint.constant = 0
        stackViewLeadingConstraint.constant = 0
        rootStackView.alpha = 1
        view.layoutIfNeeded()
        
        // Slide out animation for the question
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut) {
            self.stackViewLeadingConstraint.constant = -1000
            self.stackViewTrailingConstraint.constant = 1000
            self.rootStackView.alpha = 0
            self.view.layoutIfNeeded()
        }
    }
    
    func displayQuestion() {
        guard questions.count > 0 && currentQuestionIndex < questions.count else {
            return
        }
        
        // Display the question text
        questionLabel.text = questions[currentQuestionIndex].question
        
        // Reload the answers table
        tableView.reloadData()
        
        // Run the question slide in animation on the main thread
        DispatchQueue.main.async {
            self.slideInQuestion()
        }
    }
    
    // MARK: - QuizProtocol Methods
    
    func questionsRetrieved(_ questions: [Question]) {
        self.questions = questions
        
        // Check whether to restore the quiz state from UserDefaults storage before showing the first question
        let savedIndex = StateManager.retrieveValue(key: StateManager.questionIndexKey) as? Int
        
        if savedIndex != nil && savedIndex! < self.questions.count {
            // Set the current question to display the saved question in UserDefaults storage
            currentQuestionIndex = savedIndex!
            
            // Retrieve the number of correct answers from UserDefaults storage
            let savedNumCorrect = StateManager.retrieveValue(key: StateManager.numCorrectKey) as? Int
            
            if savedNumCorrect != nil {
                numCorrect = savedNumCorrect!
            }
        }
        
        // Display the first question
        displayQuestion()
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
            let question = questions[currentQuestionIndex]
            
            if question.answers != nil && indexPath.row < question.answers!.count {
                // Set the answer text for the label
                label!.text = question.answers![indexPath.row]
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var titleText = ""
        
        let question = questions[currentQuestionIndex]
        
        // Check if user has tapped on the right answer
        if question.correctAnswerIndex! == indexPath.row {
            titleText = "Correct!"
            numCorrect += 1
        } else {
            titleText = "Incorrect!"
        }
        
        // Run the question slide out animation on the main thread
        DispatchQueue.main.async {
            self.slideOutQuestion()
        }
        
        // Display the result modal window
        if resultDialog != nil {
            // Set the appropiate result text
            resultDialog?.titleText = titleText
            resultDialog?.feedbackText = question.feedback!
            resultDialog?.buttonText = "Next"
            
            // Use the main thread to notify the view controller to update the UI
            DispatchQueue.main.async {
                self.present(self.resultDialog!, animated: true)
            }
        }
    }
    
    // MARK: - ResultViewControllerProtocol Methods
    
    func dialogDismissed() {
        // Increment the currentQuestionIndex
        currentQuestionIndex += 1
        
        if currentQuestionIndex == questions.count {
            // Show a summary dialog after the user answered the last question
            if resultDialog != nil {
                // Set the appropiate summary text
                resultDialog?.titleText = "Summary"
                resultDialog?.feedbackText = "You've got \(numCorrect) correct out of \(questions.count) questions."
                resultDialog?.buttonText = "Restart"
                
                present(resultDialog!, animated: true)
                
                // Clear the quiz state from UserDefaults storage at the end of the last question
                StateManager.clearState()
            }
        } else if currentQuestionIndex > questions.count {
            // Restart quiz
            numCorrect = 0
            currentQuestionIndex = 0
            displayQuestion()
        } else if currentQuestionIndex < questions.count {
            // Display the next question
            displayQuestion()
            
            StateManager.saveState(numCorrect: numCorrect, questionIndex: currentQuestionIndex)
        }
    }

}
