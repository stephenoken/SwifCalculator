//
//  ViewController.swift
//  Calculator
//
//  Created by Stephen O'Kennedy on 22/04/2016.
//  Copyright © 2016 Stephen O'Kennedy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private weak var display: UILabel!
    
    private var userIsInTheMiddleOfTyping = false
    private var userIsLeftOfFloatingPoint = true
    
    @IBAction private func touchDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTyping{
            let  textCurrentlyInDisplay = display.text!
            display.text = textCurrentlyInDisplay + digit
        }else{
            display.text = digit
        }
        userIsInTheMiddleOfTyping = true
    }
    //Initialiser
    private var displayValue: Double{
        get{
            return Double(display.text!)!
        }
        set{
            display.text = String(newValue)
        }
    }
    
    private let brain = CalculatorBrain()
    
    var savedProgram: CalculatorBrain.PropertyList?
    @IBAction func save() {
        savedProgram = brain.program
    }
    
    @IBAction func restore() {
        if savedProgram != nil{
            brain.program = savedProgram!
            displayValue = brain.result
        }
    }
    
    @IBAction func makeFloatingPoint() {
        if let value = display.text{
            if !value.containsString(".") {
                display.text = value + "."
            } else if value[value.endIndex.predecessor()] == "."{
                display.text = value.substringToIndex(value.endIndex.predecessor())
            }
        }
    }
    @IBAction private func performOperation(sender: UIButton) {
        if userIsInTheMiddleOfTyping {
            brain.setOperand(displayValue)
            userIsInTheMiddleOfTyping = false
            userIsLeftOfFloatingPoint = true
        }
        
        if let mathematicalSymbol = sender.currentTitle {
            brain.performOperation(mathematicalSymbol)
        }
        displayValue = brain.result
    }
}
