//
//  NumberFormatterBuilder.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 16/06/23.
//

import Foundation


class NumberFormatterBuilder: NumberFormatter {
    
    static var get: NumberFormatter { return NumberFormatter()}
    
    override init() {
        super.init()
        initialization()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialization() {
        setNumberStyle(.decimal)
        setMinimumFractionDigits(0)
        setMaximumFractionDigits(2)
    }
    
    
//  MARK: - GET Properties
    
    func getNumber(_ value: String) -> NSNumber? {
        let sanitizedValue = sanitizationNumber(value)
        if let formattedString = self.number(from: sanitizedValue) {
            return formattedString
        }
        return nil
    }
    
    func getNumber(_ value: Double) -> NSNumber? {
        return getNumber("\(value)")
    }
    
    private func sanitizationNumber(_ value: String) -> String {
        return value.replacingOccurrences(of: K.String.dot, with: decimalSeparator).replacingOccurrences(of: K.String.comma, with: decimalSeparator)
    }
    

    func getString(_ value: String) -> String? {
        let sanitizedValue = sanitizationNumber(value)
        if let formattedString = self.number(from: sanitizedValue) {
            return "\(formattedString)"
        }
        return nil
    }
    
    func getString(_ value: Double) -> String? {
        if value.isNaN { return nil }
        return self.getString(NSNumber(value: value))
    }
    
    
    
//  MARK: - SET Properties
    
    @discardableResult
    func setNumberStyle(_ style: NumberFormatter.Style) -> Self {
        self.numberStyle = style
        return self
    }
    
    @discardableResult
    func setMinimumFractionDigits(_ minimum: Int) -> Self {
        self.minimumFractionDigits = minimum
        return self
    }
    
    @discardableResult
    func setMaximumFractionDigits(_ maximum: Int) -> Self {
        self.maximumFractionDigits = maximum
        return self
    }
    
    @discardableResult
    func removeGroupingSeparator() -> Self {
        self.usesGroupingSeparator = false
        return self
    }
    
    
//  MARK: - PRIVATE Area
    
    
    private func getString(_ value: NSNumber) -> String? {
        if let formattedString = self.string(from: value) {
            return formattedString
        }
        return nil
    }
    
    
}
