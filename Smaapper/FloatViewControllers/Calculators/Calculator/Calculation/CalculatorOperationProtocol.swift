//
//  CalculatorOperationProtocol.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 20/06/23.
//

import Foundation

protocol CalculatorOperationProtocol {
    func calculate(_ previousValue: Double, _ currentValue: Double) -> Double
}
