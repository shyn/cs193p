//
//  ViewController.swift
//  Caculator
//
//  Created by deepwind on 4/15/17.
//  Copyright © 2017 deepwind. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    @IBOutlet weak var dispplayEvaluation: UILabel!

    var userIsInTheMiddleOfTyping = false
    
    var brain = caculatorBrain()
    
    @IBAction func appendDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        print("digit=\(digit)")
        if digit != "." || (display.text?.range(of: ".") == nil) {
            if userIsInTheMiddleOfTyping {
                display.text = display.text! + digit
            }
            else
            {
                display.text = digit
                userIsInTheMiddleOfTyping = true
            }
        }
    }
    
    @IBAction func operate(_ sender: UIButton) {
        let operation = sender.currentTitle!
        if userIsInTheMiddleOfTyping {
            enter()
        }
        if let result = brain.performOperation(symbol: operation) {
            displayValue = result
        } else {
            displayValue = 0
        }
    }
    
    
    @IBAction func enter() {
        userIsInTheMiddleOfTyping = false
        if let result = brain.pushOperand(operand: displayValue) {
            displayValue = result
        } else {
            displayValue = 0
        }
    }
    
    @IBAction func clear() {
        brain.clearOpStack()
        displayValue = 0
        dispplayEvaluation.text = "0"
    }
    var displayValue: Double {
        // using computed property is so elegent! 
        get {
            // parse string to double and return it
            return NumberFormatter().number(from: display.text!)!.doubleValue
        }
        set {
            display.text = "\(newValue)"
//            userIsInTheMiddleOfTyping = false
        }
    }
}

