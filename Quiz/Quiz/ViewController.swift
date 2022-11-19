//
//  ViewController.swift
//  Quiz
//
//  Created by sunny on 2022/11/17.
//

import UIKit

class ViewController: UIViewController {
    
    

    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var answerLabel: UILabel!
    
    let questions: [String] = [
        "What is 7+7",
        "What is the capital of China",
        "What is 3*8"
    ]
    let answers: [String] = [
        "14",
        "Beijing",
        "24"
    ]
    var currentQuestionIndex: Int = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questionLabel.text = questions[currentQuestionIndex];
    }
    
    @IBAction func showNextQuestion(_sender: UIButton) {
        currentQuestionIndex += 1;
        if currentQuestionIndex == questions.count {
            currentQuestionIndex = 0;
        }
        let question: String = questions[currentQuestionIndex];
        questionLabel.text = question;
        answerLabel.text = "???";
    }
    
    @IBAction func showAnswer(_sender: UIButton) {
        let answer: String = answers[currentQuestionIndex];
        answerLabel.text = answer;
    }
}

