//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Stephen O'Kennedy on 24/04/2016.
//  Copyright © 2016 Stephen O'Kennedy. All rights reserved.
//

import Foundation

class CalculatorBrain{
    
    private var accumulator = 0.0
    func setOperand (operand:Double){
        accumulator = operand
    }
    
    private let operations: Dictionary<String,Operation> = [
        "π": Operation.Constant(M_PI),
        "e": Operation.Constant(M_E),
        "√": Operation.UnaryConstant,
        "cos": Operation.UnaryConstant
    ]
    
    enum Operation{
        case Constant(Double)
        case UnaryConstant
        case BinaryConstant
        case Equals
    }
    func performOperation(symbol:String){
        if let operation = operations[symbol]{
            switch operation {
            case .Constant(let value): accumulator = value
            case .BinaryConstant:break
            case .UnaryConstant:break
            case .Equals: break
            }
        }
    }
    
    var result:Double {
        get{
            return accumulator
        }
    }
}