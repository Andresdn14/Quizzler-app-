

import UIKit

class ViewController: UIViewController {
    
    let allQuestions = QuestionBank()
    var pickedAnswer: Bool = false
    var questionNumber: Int = 0
    var score: Int = 0
    //Place your instance variables here
    
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scoreLabel.text = "Score: 0"
        nextQuestion()
        
    }


    @IBAction func answerPressed(_ sender: AnyObject) {
        if sender.tag == 1 {
            pickedAnswer = true
        } else if sender.tag == 2 {
            pickedAnswer = false
        }
        checkAnswer()
        
        questionNumber += 1
        if questionNumber <= allQuestions.list.count {
            nextQuestion()
        } else {
            startOver()
        }
        
    }
    
    
    func updateUI() {
        scoreLabel.text = "Score: \(score)"
        progressLabel.text = "\(questionNumber+1) / 13"
        progressBar.frame.size.width = (view.frame.size.width / 13) * CGFloat(questionNumber+1)
    }
    

    func nextQuestion() {
        if questionNumber <= 12{
            
        questionLabel.text = allQuestions.list[questionNumber].questionText
            
        }else {
            let alert = UIAlertController(title: "Firme", message: "Tonces empiezas again?", preferredStyle: .alert)
            
            let restartAction = UIAlertAction(title: "Sisa", style: .default) { (UIAlertAction) in
                self.startOver()
            }
            let CancelRestart = UIAlertAction(title: "Nadal", style: .default) { (UIAlertAction) in
                self.startOver()
            }
            alert.addAction(restartAction)
            alert.addAction(CancelRestart)
            present(alert, animated: true, completion: nil)
        }
        updateUI()
    }
    
    
    func checkAnswer() {
        
        let correctAnswer = allQuestions.list[questionNumber].answer
        
        if correctAnswer == pickedAnswer {
            ProgressHUD.showSuccess("Correct!")
            score = score + 1000
            
        }else{
            ProgressHUD.showError("Ñie.. no vales mondá")
        }
    }
    
    
    func startOver() {
        questionNumber = 0
        score = 0
        nextQuestion()
    }
    

    
}
