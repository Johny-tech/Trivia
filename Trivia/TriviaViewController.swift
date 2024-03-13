//
//  TriviaViewController.swift
//  Trivia
//
//  Created by Administrator on 3/13/24.
//

import UIKit


class TriviaViewController: UIViewController {

    @IBOutlet weak var QuestionNumberLabel: UILabel!
    @IBOutlet weak var QuestionLabel: UILabel!
    
    @IBOutlet weak var ResetButton: UIButton!
    var questions: [Question] = [
           Question(question: "What is the capital of France?", answers: ["Berlin", "Paris", "Madrid"], correctAnswerIndex: 1),
           Question(question: "Which planet is known as the Red Planet?", answers: ["Venus", "Mars", "Jupiter"], correctAnswerIndex: 1),
           Question(question: "What is the largest mammal in the world?", answers: ["Elephant", "Blue Whale", "Giraffe"], correctAnswerIndex: 1)
       ]
    
    @IBOutlet weak var Answer2: UIButton!
    @IBOutlet weak var Answer3: UIButton!
    @IBOutlet weak var Answer1: UIButton!
    
    var currentQuestionIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        updateUIWithCurrentQuestion()
        ResetButton.isHidden = true
//        ResetButton.va = "Reset"

        // Do any additional setup after loading the view.
    }
    
    func updateUIWithCurrentQuestion() {
        let currentQuestion = questions[currentQuestionIndex]
        QuestionNumberLabel.text = "Question \(currentQuestionIndex + 1)"
        QuestionLabel.text = currentQuestion.question
        Answer1.setTitle(currentQuestion.answers[0], for: .normal)
        Answer2.setTitle(currentQuestion.answers[1], for: .normal)
        Answer3.setTitle(currentQuestion.answers[2], for: .normal)
    }
    
    
    @IBAction func ResetQuestions(_ sender: Any) {
        currentQuestionIndex = 0
           ResetButton.isHidden = true
           updateUIWithCurrentQuestion()
        
    }
    
    
    @IBAction func Button1Tapped(_ sender: Any) {
        
        currentQuestionIndex += 1
           
           // Check if there are more questions
           if currentQuestionIndex < questions.count {
               updateUIWithCurrentQuestion()
           } else {
               // Display a message or perform any action when all questions are answered
               ResetButton.isHidden = false
               print("You reached the Queestion Limit")
           }
        
    }
    
    @IBAction func Button2Tapped(_ sender: Any) {
        currentQuestionIndex += 1
           
           // Check if there are more questions
           if currentQuestionIndex < questions.count {
               updateUIWithCurrentQuestion()
           } else {
               // Display a message or perform any action when all questions are answered
               ResetButton.isHidden = false
               print("You reached the Queestion Limit")
           }
    }
    
    
    @IBAction func Button3Tapped(_ sender: Any) {
        currentQuestionIndex += 1
        
        if currentQuestionIndex < questions.count {
            updateUIWithCurrentQuestion()
        } else {
            // Display a message or perform any action when all questions are answered
            ResetButton.isHidden = false
            print("You reached the Queestion Limit")
        }
    }
    
    /*
    // MARK: - Navigation

     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
