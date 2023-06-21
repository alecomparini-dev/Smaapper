//
//  Calculation.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 20/06/23.
//

import Foundation

class Calculation {
    
    var operation: CalculatorOperationProtocol?
    var previousValue: Double?
    var currentValue: Double?
    var result: Double?
    
//  MARK: - CALCULATE
    var calculate: Double? {
        guard let previousValue,
              let currentValue,
              let operation else {return nil}
        let result = operation.calculate(previousValue, currentValue)
        resetCalculation()
        self.result = result
        return result
    }
    
    func resetCalculation() {
        self.operation = nil
        self.previousValue = nil
        self.currentValue = nil
    }
    
}
