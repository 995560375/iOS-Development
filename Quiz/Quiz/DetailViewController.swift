//
//  DetailViewController.swift
//  Quiz
//
//  Created by sunny on 2022/11/26.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var answerField: UITextField!
    @IBOutlet var selectionField: UITextField!
    @IBOutlet var questionField: UITextField!
    
    var item: Item!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        questionField.text = item.question;
        selectionField.text = item.selection;
        answerField.text = item.answer;
        dateLabel.text = "\(item.dateCreated)"
    }
}
