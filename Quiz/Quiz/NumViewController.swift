//
//  ViewController.swift
//  Quiz
//
//  Created by sunny on 2022/11/17.
//

import UIKit

class NumViewController: UIViewController {
    
    

    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var answerLabel: UILabel!
    @IBOutlet var textField: UITextField!;
    @IBOutlet var correctOrNot: UILabel!;
    var answer: Double = 0;
    
    
    let questions: [String] = [
        "When did Avatar come out?",
        "How many houses in Hogwarts?",
        "How many movies in the bourne identity series?"
    ]
    let answers: [Double] = [
        2009,
        4,
        5
    ]
    var currentQuestionIndex: Int = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questionLabel.text = questions[currentQuestionIndex];
        correctOrNot.text = "";
    }
    
    @IBAction func showNextQuestion(_sender: UIButton) {
        currentQuestionIndex += 1;
        correctOrNot.text = "";
        textField.text = "";
        if currentQuestionIndex == questions.count {
            currentQuestionIndex = 0;
        }
        let question: String = questions[currentQuestionIndex];
        questionLabel.text = question;
        answerLabel.text = "???";
    }
    
    @IBAction func showAnswer(_sender: UIButton) {
        let answer: Double = answers[currentQuestionIndex];
        answerLabel.text = String(answer);
    }
    
    @IBAction func changeAnswer(_textField: UITextField) {
        let text = textField.text;
        if text != nil {
            answer = Double(text!) ?? 0.0;
        } else {
            answer = 0;
        }
        print(answer);
    }
    
    @IBAction func submit(_sender: UIButton) {
//        guard let vc = storyboard?.instantiateViewController(withIdentifier: "ScoreViewController") as? ScoreViewController else {return}
//        vc.correct = 1;
//        print(vc.correct);
//        print(vc.wrong);
//        self.navigationController?.pushViewController(vc, animated: true);
        
        if answer == answers[currentQuestionIndex] {
            correctOrNot.text = "Correct";
            correctOrNot.textColor = UIColor.green;
            print("correct");
        } else {
            correctOrNot.text = "Wrong"
            correctOrNot.textColor = UIColor.red;
            print("wrong");
        }
        
    }
    
    @IBAction func dismissKeyboard(_sender: UITapGestureRecognizer) {
        textField.resignFirstResponder();
    }
}

