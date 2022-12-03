//
//  DrawView.swift
//  Quiz
//
//  Created by sunny on 2022/11/30.
//

import UIKit

class DrawView: UIView, UIGestureRecognizerDelegate {

//    var currentLine: Line?
    var currentLines = [NSValue:Line]()
    var finishedLines = [Line]()
    var curColor = UIColor.black
    var selectedLineIndex: Int? {
        didSet {
            if selectedLineIndex == nil {
//                let menu = UIMenuController.shared
//                menu.setMenuVisible(false, animated: true)
            }
        }
    }
    
    var moveRecognizer: UIPanGestureRecognizer!
    
    @IBInspectable var finishedLineColor: UIColor = UIColor.black {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var currentLineColor: UIColor = UIColor.red {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var lineThickness: CGFloat = 10 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
        let doubleTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(DrawView.doubleTap(_:)))
        doubleTapRecognizer.numberOfTapsRequired = 2;
        doubleTapRecognizer.delaysTouchesBegan = true
        addGestureRecognizer(doubleTapRecognizer)
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(DrawView.tap(_:)))
        tapRecognizer.delaysTouchesBegan = true
        tapRecognizer.require(toFail: doubleTapRecognizer)
        addGestureRecognizer(tapRecognizer)
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(DrawView.longPress(_:)))
        addGestureRecognizer(longPressRecognizer)
        
        moveRecognizer = UIPanGestureRecognizer(target: self, action: #selector(DrawView.moveLine(_:)))
        moveRecognizer.delegate = self
        moveRecognizer.cancelsTouchesInView = false
        addGestureRecognizer(moveRecognizer)
    }
    
    func stroke(_ line: Line) {
        let path = UIBezierPath()
//        path.lineWidth = 10
        path.lineWidth = lineThickness
        path.lineCapStyle = .round;
        
        path.move(to: line.begin);
        path.addLine(to: line.end);
        path.stroke()
    }
    
    @objc func doubleTap(_ gestureRecognizer: UITapGestureRecognizer) {
        print("Recognized a double tap")
        selectedLineIndex = nil
        currentLines.removeAll()
        finishedLines.removeAll()
        setNeedsDisplay()
    }
    
    @objc func moveLine(_ gestureRecognizer: UIPanGestureRecognizer) {
        print("A pan")
        if let index = selectedLineIndex {
            if gestureRecognizer.state == .changed {
                let translation = gestureRecognizer.translation(in: self)
                
                finishedLines[index].begin.x += translation.x
                finishedLines[index].begin.y += translation.y
                finishedLines[index].end.x += translation.x
                finishedLines[index].end.y += translation.y
                
                gestureRecognizer.setTranslation(CGPoint.zero, in: self)
                
                setNeedsDisplay()
            }
        } else {
            return
        }
    }
    
    @objc func longPress(_ gestureRecognizer: UIGestureRecognizer) {
        print("Long press")
        if gestureRecognizer.state == .began {
            let point = gestureRecognizer.location(in: self)
            selectedLineIndex = indexOfLine(at: point)
            if selectedLineIndex != nil {
                currentLines.removeAll()
                
            } else {
                print("nothing")
                let menu = UIMenuController.shared
                becomeFirstResponder()
                let redColor = UIMenuItem(title: "Red", action: #selector(DrawView.penRed(_:)))
                let blueColor = UIMenuItem(title: "Blue", action: #selector(DrawView.penBlue(_:)))
                let greenColor = UIMenuItem(title: "Green", action: #selector(DrawView.penGreen(_:)))
                let grayColor = UIMenuItem(title: "Gray", action: #selector(DrawView.penGray(_:)))
                menu.menuItems = [redColor, blueColor, greenColor, grayColor]
                let targetRect = CGRect(x: point.x, y: point.y, width: 2, height: 2)
                menu.setTargetRect(targetRect, in: self)
                menu.setMenuVisible(true, animated: true)
                
            }
        } else if gestureRecognizer.state == .ended {
            selectedLineIndex = nil
        }
    }
    
    @objc func tap(_ gestureRecognizer: UITapGestureRecognizer) {
        print("Recognized a tap")
        let point = gestureRecognizer.location(in: self)
        selectedLineIndex = indexOfLine(at: point)
        
        let menu = UIMenuController.shared
        if selectedLineIndex != nil {
            becomeFirstResponder()
            let deleteItem = UIMenuItem(title: "Delete", action: #selector(DrawView.deleteLine(_:)))
            let redColor = UIMenuItem(title: "Red", action: #selector(DrawView.turnRed(_:)))
            let blueColor = UIMenuItem(title: "Blue", action: #selector(DrawView.turnBlue(_:)))
            let greenColor = UIMenuItem(title: "Green", action: #selector(DrawView.turnGreen(_:)))
            let grayColor = UIMenuItem(title: "Gray", action: #selector(DrawView.turnGray(_:)))
            menu.menuItems = [deleteItem, redColor, blueColor, greenColor, grayColor]
//            menu.menuItems = [redColor]
            let targetRect = CGRect(x: point.x, y: point.y, width: 2, height: 2)
            menu.setTargetRect(targetRect, in: self)
            menu.setMenuVisible(true, animated: true)
        } else {
            menu.setMenuVisible(false, animated: true)
        }
        
        setNeedsDisplay()
    }
    override var canBecomeFirstResponder: Bool {
        return true;
    }
    
    @objc func deleteLine(_ sender: UIMenuController) {
        if let index = selectedLineIndex {
            finishedLines.remove(at: index)
            selectedLineIndex = nil
            setNeedsDisplay()
        }
    }
    
    @objc func turnRed(_ sender: UIMenuController) {
        print("Red")
        if let index = selectedLineIndex {
            finishedLines[index].color = UIColor.red
        }
    }
    @objc func turnBlue(_ sender: UIMenuController) {
        print("Blue")
        if let index = selectedLineIndex {
            finishedLines[index].color = UIColor.blue
        }
    }
    @objc func turnGreen(_ sender: UIMenuController) {
        print("Green")
        if let index = selectedLineIndex {
            finishedLines[index].color = UIColor.green
        }
    }
    @objc func turnGray(_ sender: UIMenuController) {
        print("Gray")
        if let index = selectedLineIndex {
            finishedLines[index].color = UIColor.gray
        }
    }
    @objc func penRed(_ sender: UIMenuController) {
        print("penRed")
        curColor = UIColor.red
    }
    @objc func penBlue(_ sender: UIMenuController) {
        print("penBlue")
        curColor = UIColor.blue
    }
    @objc func penGray(_ sender: UIMenuController) {
        print("penGray")
        curColor = UIColor.gray
    }
    @objc func penGreen(_ sender: UIMenuController) {
        print("penGreen")
        curColor = UIColor.green
    }
    
    override func draw(_ rect: CGRect) {
//        UIColor.black.setStroke()
        for line in finishedLines {
            line.color.setStroke()
            stroke(line)
        }
        
//        if let line = currentLine {
//            UIColor.red.setStroke()
//            stroke(line)
//        }
        
//        UIColor.red.setStroke()
        currentLineColor.setStroke()
        for(_, line) in currentLines {
            stroke(line)
        }
        
        if let index = selectedLineIndex {
            UIColor.green.setStroke()
            let selectedLine = finishedLines[index]
            stroke(selectedLine)
        }
    }
    
    func indexOfLine(at point: CGPoint) -> Int? {
        for(index, line) in finishedLines.enumerated() {
            let begin = line.begin
            let end = line.end
            
            for t in stride(from: CGFloat(0), to: 1.0, by: 0.05) {
                let x = begin.x + ((end.x - begin.x) * t)
                let y = begin.y + ((end.y - begin.y) * t)
                
                if hypot(x - point.x, y - point.y) < 20.0 {
                    return index
                }
            }
        }
        return nil
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        let touch = touches.first!
//        let location = touch.location(in: self)
//        currentLine = Line(begin: location, end: location)
        print(#function)
        for touch in touches {
            let location = touch.location(in: self)
            let newLine = Line(begin: location, end: location, color: curColor)
            let key = NSValue(nonretainedObject: touch)
            currentLines[key] = newLine
        }
        setNeedsDisplay()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        let touch = touches.first!
//        let location = touch.location(in: self)
//        currentLine?.end = location
        print(#function)
        for touch in touches {
            let key = NSValue(nonretainedObject: touch)
            currentLines[key]?.end = touch.location(in: self)
        }
        setNeedsDisplay()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        if var line = currentLine {
//            let touch = touches.first!
//            let location = touch.location(in: self)
//            line.end = location
//            finishedLines.append(line)
//        }
//        currentLine = nil
        print(#function)
        for touch in touches {
            let key = NSValue(nonretainedObject: touch)
            if var line = currentLines[key] {
                line.end = touch.location(in: self)
                finishedLines.append(line)
                currentLines.removeValue(forKey: key)
            }
        }
        setNeedsDisplay()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(#function)
        currentLines.removeAll()
        setNeedsDisplay()
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
