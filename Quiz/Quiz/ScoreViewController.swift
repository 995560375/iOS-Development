//
//  ScoreViewController.swift
//  Quiz
//
//  Created by sunny on 2022/11/19.
//

import UIKit


class ScoreViewController: UIViewController {
    
    @IBOutlet var correctLabel: UILabel!
    public var correct = 0;
    @IBOutlet var wrongLabel: UILabel!
    var wrong = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        correctLabel.text = "\(correct)";
        wrongLabel.text = "\(wrong)";
    }
}
