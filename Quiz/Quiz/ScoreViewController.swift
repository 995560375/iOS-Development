//
//  ScoreViewController.swift
//  Quiz
//
//  Created by sunny on 2022/11/19.
//

import UIKit


class ScoreViewController: UIViewController {
    
    @IBOutlet var correctLabel: UILabel!
    public var correct = "";
    @IBOutlet var wrongLabel: UILabel!
    var wrong = "";
    
    override func viewDidLoad() {
        super.viewDidLoad();
        let correctNum = ShareScore.shareInstance.correct
        let wrongNum = ShareScore.shareInstance.wrong
        correctLabel.text = String(correctNum)
        wrongLabel.text = String(wrongNum)
        if correctNum > wrongNum {
            self.view.backgroundColor = UIColor.green
        } else if correctNum < wrongNum {
            self.view.backgroundColor = UIColor.red
        } else {
            self.view.backgroundColor = UIColor.white
        }
//        correctLabel.text = "\(correct)";
//        wrongLabel.text = "\(wrong)";
        
    }
    
    
    @IBAction func refreshScore(_ sender: Any) {
        viewDidLoad()
    }
}
