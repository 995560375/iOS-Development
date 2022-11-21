//
//  MultipleViewController.swift
//  Quiz
//
//  Created by sunny on 2022/11/19.
//

import UIKit;

class MultipleViewController: UIViewController {
    
    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var selectionsLabel: UILabel!
    @IBOutlet var answerLabel: UILabel!
//    @IBOutlet var textField: UITextField!;
    @IBOutlet var correctOrNot: UILabel!;
    @IBOutlet weak var choosePickerView: UIPickerView!;
    var answer: String = "";
    let array = ["A", "B", "C", "D"];
    
    let questions: [String] = [
        "What is the name of the latest Battlefield?",
        "What is 3*9?",
        "When did Green Book come out?"
    ]
    
    let selections: [String] = [
        "A: 2000 B: 2001 C: 2042 D: 2009",
        "A: 21 B: 24 C: 27 D: 30",
        "A: 2000 B: 2018 C: 2042 D: 2009"
    ]
    
    let answers: [String] = [
        "C",
        "C",
        "B"
    ]
    var currentQuestionIndex: Int = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        correctOrNot.text = "";
        questionLabel.text = questions[currentQuestionIndex];
        selectionsLabel.text = selections[currentQuestionIndex];
        choosePickerView.delegate = self;
        choosePickerView.dataSource = self;
    }
    
    @IBAction func showNextQuestion(_sender: UIButton) {
        currentQuestionIndex += 1;
        correctOrNot.text = "";
        if currentQuestionIndex == questions.count {
            currentQuestionIndex = 0;
        }
        let question: String = questions[currentQuestionIndex];
        let selection: String = selections[currentQuestionIndex];
        selectionsLabel.text = selection;
        questionLabel.text = question;
        answerLabel.text = "???";
        choosePickerView.delegate = self;
        choosePickerView.dataSource = self;
    }
    
    @IBAction func showAnswer(_sender: UIButton) {
        let answer: String = answers[currentQuestionIndex];
        answerLabel.text = String(answer);
    }
    
    
    
    @IBAction func submit(_sender: UIButton) {
        print(answer);
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
}

extension MultipleViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return array.count;
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return array[row];
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        answer = array[row];
    }
}
