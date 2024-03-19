//
//  TriviaViewController.swift
//  Trivia
//
//  Created by Administrator on 3/13/24.
//

import UIKit


class TriviaViewController: UIViewController {
    let questionService = QuestionService()
    @IBOutlet weak var QuestionNumberLabel: UILabel!
    @IBOutlet weak var QuestionLabel: UILabel!
        
    @IBOutlet weak var ResetButton: UIButton!
    
    
//    var questions: [Question] = [
//           Question(question: "What is the capital of France?", answers: ["Berlin", "Paris", "Madrid"], correctAnswerIndex: 1),
//           Question(question: "Which planet is known as the Red Planet?", answers: ["Venus", "Mars", "Jupiter"], correctAnswerIndex: 1),
//           Question(question: "What is the largest mammal in the world?", answers: ["Elephant", "Blue Whale", "Giraffe"], correctAnswerIndex: 1)
//       ]
    var questions : [Question] = []
    
    @IBOutlet weak var Answer2: UIButton!
    @IBOutlet weak var Answer3: UIButton!
    @IBOutlet weak var Answer1: UIButton!
    var score=0
    
    var currentQuestionIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        fetchQuestionsFromApi()
//        updateUIWithCurrentQuestion()
        ResetButton.isHidden = true
        
//        ResetButton.va = "Reset"

        // Do any additional setup after loading the view.
    }
    
    func fetchQuestionsFromApi() {
        questionService.fetchQuestions { [weak self] questionResponse in
            DispatchQueue.main.async {
                if let questionResponse = questionResponse {
                    self?.questions = questionResponse.results
                    self?.updateUIWithCurrentQuestion()
                } else {
                    // Handle error
                    print("Failed to fetch questions")
                }
            }
        }
    }
    
    
    func updateUIWithCurrentQuestion() {
        let currentQuestion = questions[currentQuestionIndex]
        QuestionNumberLabel.text = "Question \(currentQuestionIndex + 1)"
        QuestionLabel.text = currentQuestion.question
        QuestionLabel.text = currentQuestion.question
               Answer1.setTitle(currentQuestion.correctAnswer, for: .normal)
               Answer2.setTitle(currentQuestion.incorrectAnswers[0], for: .normal)
               Answer3.setTitle(currentQuestion.incorrectAnswers[1], for: .normal)
    }
    
    
    @IBAction func ResetQuestions(_ sender: Any) {
        currentQuestionIndex = 0
           ResetButton.isHidden = true
            restartGame()
        
    }
    
//
//    @IBAction func ResetQuestions(_ sender: Any) {
//          currentQuestionIndex = 0
//          ResetButton.isHidden = true
//          updateUIWithCurrentQuestion()
//      }

      @IBAction func Button1Tapped(_ sender: Any) {
          handleAnswerTapped(at: 0)
      }

      @IBAction func Button2Tapped(_ sender: Any) {
          handleAnswerTapped(at: 1)
      }

      @IBAction func Button3Tapped(_ sender: Any) {
          handleAnswerTapped(at: 2)
      }
    
    
      func handleAnswerTapped(at index: Int) {
          let currentQuestion = questions[currentQuestionIndex]
          if index == 0 {
              // Correct answer tapped
              print("Correct answer tapped")
              score += 1
          } else {
              // Incorrect answer tapped
              print("Incorrect answer tapped")
          }

          currentQuestionIndex += 1

          // Check if there are more questions
          if currentQuestionIndex < questions.count {
              updateUIWithCurrentQuestion()
          } else {
              // Display a message or perform any action when all questions are answered
              ResetButton.isHidden = false
              print("You reached the Question Limit")
              displayScoreboard()
              
          }
      }
    
    func displayScoreboard() {
            let alert = UIAlertController(title: "Scoreboard", message: "Your Score: \(score) / \(questions.count)", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { _ in
                print("ok clicked")
            }
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        }
        
        func restartGame() {
            currentQuestionIndex = 0
            score = 0
            fetchQuestionsFromApi() // Start with new questions
            ResetButton.isHidden = true
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
