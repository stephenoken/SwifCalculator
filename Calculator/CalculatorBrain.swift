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
        "+/−": Operation.UnaryConstant({-$0}),
        "√": Operation.UnaryConstant(sqrt),
        "cos": Operation.UnaryConstant(cos),
        "×": Operation.BinaryConstant({$0 * $1}),
        "÷": Operation.BinaryConstant({$0 / $1}),
        "+": Operation.BinaryConstant({$0 + $1}),
        "−": Operation.BinaryConstant({$0 - $1}),
        "=":Operation.Equals
    ]
    
    
    private enum Operation{
        case Constant(Double)
        case UnaryConstant((Double)->Double)
        case BinaryConstant((Double,Double) -> Double)
        case Equals
    }
    
    func performOperation(symbol:String){
        if let operation = operations[symbol]{
            switch operation {
            case .Constant(let value):
                accumulator = value
            case .UnaryConstant(let function):
                accumulator = function(accumulator)
            case .BinaryConstant(let function):
                executePendingBinaryOperation()
                pending = PendingBinaryOperationInfo(binaryFunction: function, firstOperand: accumulator)
            case .Equals:
                executePendingBinaryOperation()
            }
        }
    }
    
    private func executePendingBinaryOperation() {
        if pending != nil {
            accumulator = pending!.binaryFunction(pending!.firstOperand,accumulator)
            pending = nil
        }
    }
    private var pending: PendingBinaryOperationInfo?
    
    private struct PendingBinaryOperationInfo{
        var binaryFunction:(Double,Double) -> Double
        var firstOperand: Double
    }
    
    var result:Double {
        get{
            return accumulator
        }
    }
}