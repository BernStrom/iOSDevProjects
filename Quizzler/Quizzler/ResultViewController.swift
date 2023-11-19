//
//  ResultViewController.swift
//  Quizzler
//
//  Created by Bern N on 11/20/23.
//

import UIKit

class ResultViewController: UIViewController {
    
    @IBOutlet weak var dimView: UIView!
    
    @IBOutlet weak var dialogView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var feedbackLabel: UILabel!
    
    @IBOutlet weak var dismissButton: UIButton!
    
    var titleText = ""
    var feedbackText = ""
    var buttonText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel?.text = titleText
        feedbackLabel.text = feedbackText
        dismissButton.setTitle(buttonText, for: .normal)
    }
    
    @IBAction func dismissTapped(_ sender: Any) {
        // TODO: - Dismiss the result modal window
    }
    
}
