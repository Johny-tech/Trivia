import Foundation
class QuestionService {
    func fetchQuestions(completion: @escaping (QuestionResponse?) -> Void) {
        guard let url = URL(string: "https://opentdb.com/api.php?amount=10&category=10&difficulty=medium&type=multiple") else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            do {    
                let questionResponse = try self.parseQuestionResponse(data: data)
                completion(questionResponse)
            } catch {
                print("Error decoding JSON: \(error.localizedDescription)")
                completion(nil)
            }
        }.resume()
    }
    
    private func parseQuestionResponse(data: Data) throws -> QuestionResponse {
        let jsonDictionary = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
        let responseCode = jsonDictionary["response_code"] as! Int
        let resultsArray = jsonDictionary["results"] as! [[String: Any]]
        let questions = resultsArray.compactMap { parseQuestion(dictionary: $0) }
        return QuestionResponse(responseCode: responseCode, results: questions)
    }
    
    private func parseQuestion(dictionary: [String: Any]) -> Question? {
        guard let type = dictionary["type"] as? String,
              let difficulty = dictionary["difficulty"] as? String,
              let category = dictionary["category"] as? String,
              let question = dictionary["question"] as? String,
              let correctAnswer = dictionary["correct_answer"] as? String,
              let incorrectAnswers = dictionary["incorrect_answers"] as? [String] else {
            return nil
        }
        return Question(type: type, difficulty: difficulty, category: category, question: question, correctAnswer: correctAnswer, incorrectAnswers: incorrectAnswers)
    }
}
