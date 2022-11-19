//
//  ViewController.swift
//  WorldTrotter
//
//  Created by sunny on 2022/11/18.
//

import UIKit

class ConversionViewController: UIViewController {
    
    @IBOutlet var celsiusLabel: UILabel!;
    @IBOutlet var textField: UITextField!;
    
    var fahrenheitValue: Measurement<UnitTemperature>? {
        didSet {
            updateCelsiusLabel();
        }
    }
    var celsiusValue: Measurement<UnitTemperature>? {
        if let fahrenheitValue = fahrenheitValue {
            return fahrenheitValue.converted(to: .celsius);
        } else {
            return nil;
        }
    }
    let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter();
        nf.numberStyle = .decimal;
        nf.minimumFractionDigits = 0;
        nf.maximumFractionDigits = 1;
        return nf;
    }();
    
    
    override func viewDidLoad() {
        super.viewDidLoad();
        updateCelsiusLabel();
//        let firstFrame = CGRect(x: 160, y: 240, width: 100, height: 150);
//        let firstView = UIView(frame: firstFrame);
//        firstView.backgroundColor = UIColor.blue;
//        view.addSubview(firstView);
//
//        let secondFrame = CGRect(x: 20, y: 30, width: 50, height: 50);
//        let secondView = UIView(frame: secondFrame);
//        secondView.backgroundColor = UIColor.green;
////        view.addSubview(secondView);
//        firstView.addSubview(secondView);
        
        print("ConversionViewController loaded................")
    }
    
    @IBAction func fahrenheiFieldEditingChanged(_textField: UITextField) {
//        if let text = _textField.text, !text.isEmpty {
//            celsiusLabel.text = text;
//        } else {
//            celsiusLabel.text = "???";
//        }
        
        if let text = textField.text, let value = Double(text) {
            fahrenheitValue = Measurement(value: value, unit: .fahrenheit);
        } else {
            fahrenheitValue = nil;
        }
//        print(fahrenheitValue?.value);
//        print(celsiusValue?.value);
        
    }
    
    @IBAction func dismissKeyboard(_sender: UITapGestureRecognizer) {
        textField.resignFirstResponder();
    }
    
    func updateCelsiusLabel() {
        if let celsiusValue = celsiusValue {
//            celsiusLabel.text = "\(celsiusValue.value)"
            celsiusLabel.text = numberFormatter.string(from: NSNumber(value: celsiusValue.value));
        } else {
            celsiusLabel.text = "???";
        }
    }
}

