//
//  CacultorBrain.swift
//  Caculator
//
//  Created by deepwind on 4/16/17.
//  Copyright © 2017 deepwind. All rights reserved.
//

import Foundation

class caculatorBrain
{
    // acess control strategy
    private enum Op: CustomStringConvertible
    {
        case Operand(Double)
        case BinaryOperation(String, (Double, Double)->Double)
        case UnaryOperation(String, (Double)->Double)
        case ZeroOperation(String, Double)
        
        // add read only computed property
        var description: String {
            get {
                switch self {
                case .Operand(let operand):
                    return "\(operand)"
                case .BinaryOperation(let symbol, _):
                    return symbol
                case .UnaryOperation(let symbol, _):
                    return symbol
                case .ZeroOperation(let symbol, _):
                    return symbol
                }
            }
        }
        
    }
    // emum can have accoiated values and contains only computed property
    
    private var opStack = [Op]()
    
    private var knownOps = [String:Op]()
    
    init() {
        func learnOp(op: Op) {
            knownOps[op.description] = op
        }
        learnOp(op: Op.BinaryOperation("*", *)) // 这样既利用了 __str__ 也使的这里的注册代码不再需要输入2次运算符！ Brilliant
        knownOps["÷"] = Op.BinaryOperation("÷") { $1 / $0 }
        knownOps["+"] = Op.BinaryOperation("+", +)
        knownOps["−"] = Op.BinaryOperation("−") { $1 - $0 }
        knownOps["√"] = Op.UnaryOperation("√", sqrt)
        knownOps["sin"] = Op.UnaryOperation("sin", sin)
        knownOps["cos"] = Op.UnaryOperation("cos", cos)
        knownOps["π"] = Op.ZeroOperation("π", Double.pi)
    }
//    
//    typealias PropertyList = AnyObject
//    
//    var program: PropertyList {
//        get {
//            return opStack.map { $0.description }   // This goes wrong with swift 3.1 :(
//        }
//        set {
//            if let symbolList = newValue as? Array<String> {
//                var newOpStack = [Op]()
//                for symbol in symbolList {
//                    if let myOp = knownOps[symbol] {
//                        newOpStack.append(myOp)
//                    }else{
//                        if let newNum = NumberFormatter().number(from: symbol)?.doubleValue{
//                            opStack.append(.Operand(newNum))
//                        }
//                    }
//                }
//                opStack = newOpStack
//            }
//        }
//    }
//    
    func evaluate() -> Double? {
        let (result, remainder) = evaluate(ops: opStack)
        print("\(opStack) = \(String(describing: result)) and \(remainder)")
        return result
    }
    // array and dictionary in swift are structs which passed by value
    private func evaluate( ops: [Op]) -> (result: Double?, remainingOps: [Op]) {
        if !ops.isEmpty {
            var remainingOps = ops
            let op = remainingOps.removeLast()
            switch op {
            case .Operand(let operand):
                return (operand, remainingOps)
            case .UnaryOperation(_, let operation):
                let operandEvaluation = evaluate(ops: remainingOps)
                if let operand = operandEvaluation.result {
                    return (operation(operand), operandEvaluation.remainingOps)
                }
            case .BinaryOperation(_, let operation):
                let op1Evaluation = evaluate(ops: remainingOps)
                if let operand1 = op1Evaluation.result {
                    let op2Evaluation = evaluate(ops: op1Evaluation.remainingOps)
                    if let operand2 = op2Evaluation.result {
                    return (operation(operand1, operand2), op2Evaluation.remainingOps)
                    }

                }
            case .ZeroOperation(_, let value):
                return (value, remainingOps)
            }
        }
        return (nil, ops)
    }
    
    func pushOperand(operand: Double) -> Double? {
        opStack.append(Op.Operand(operand))
        return evaluate()
    }
    
    func performOperation(symbol: String) -> Double? {
        if let operation = knownOps[symbol] {
            opStack.append(operation)
        }
        return evaluate()
    }
    func clearOpStack() {
        opStack.removeAll()
    }
}
