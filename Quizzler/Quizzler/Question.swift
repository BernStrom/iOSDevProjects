//
//  Question.swift
//  Quizzler
//
//  Created by Bern N on 11/18/23.
//

import Foundation

struct Question: Codable {
    var question: String?
    var answers: [String]?
    var correctAnswerIndex: Int?
    var feedback: String?
}
