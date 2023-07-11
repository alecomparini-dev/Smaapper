//
//  DivisionOperation.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 20/06/23.
//

import Foundation

class DivisionOperation: CalculatorOperationProtocol {
    func calculate(_ previousValue: Double, _ currentValue: Double) -> Double {
        if currentValue == 0 {
            return 0
        }
        return previousValue / currentValue
    }
}
