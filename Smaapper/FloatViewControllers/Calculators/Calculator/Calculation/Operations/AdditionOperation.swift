//
//  AdditionOperation.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 20/06/23.
//

import Foundation

class AdditionOperation: CalculatorOperationProtocol {
    func calculate(_ previousValue: Double, _ currentValue: Double) -> Double {
        return previousValue + currentValue
    }
}
