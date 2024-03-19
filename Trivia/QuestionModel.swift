//
//  QuestionModel.swift
//  Trivia
//
//  Created by Administrator on 3/13/24.
//

import Foundation
//struct Question: Codable {
//    let question: String
//    let answers: [String]
//    let correctAnswerIndex: Int
//}
struct Question: Codable {
    let type: String
    let difficulty: String
    let category: String
    let question: String
    let correctAnswer: String
    let incorrectAnswers: [String]
}

struct QuestionResponse: Codable {
    let responseCode: Int
    let results: [Question]
}
