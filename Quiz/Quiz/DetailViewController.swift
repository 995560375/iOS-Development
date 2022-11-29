//
//  DetailViewController.swift
//  Quiz
//
//  Created by sunny on 2022/11/26.
//

import UIKit

class DetailViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var answerField: UITextField!
    @IBOutlet var selectionField: UITextField!
    @IBOutlet var questionField: UITextField!
    
    var item: Item!
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        answerField.resignFirstResponder();
        selectionField.resignFirstResponder();
        questionField.resignFirstResponder();
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        questionField.text = item.question;
        selectionField.text = item.selection;
        answerField.text = item.answer;
        dateLabel.text = "\(item.dateCreated)"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        item.question = questionField.text ?? ""
        item.selection = selectionField.text ?? ""
        item.answer = answerField.text ?? ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
}
