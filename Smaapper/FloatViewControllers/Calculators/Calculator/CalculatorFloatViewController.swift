//
//  CalculatorFloatViewController.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 16/06/23.
//

import UIKit

class CalculatorFloatViewController: FloatViewController {
    static let identifierApp = "calculator"
    
    private var operation: CalculatorOperationProtocol?
    
    private let calc: Calculation = Calculation()
    private let numberFormatter: NumberFormatterBuilder = NumberFormatterBuilder()
    private var isPercentageTapped: Bool = false
    private var isFinishedTypingNumber: Bool = true
    private var isCurrentValue: Bool = false
    
    lazy var screen: CalculatorView = {
        let view = CalculatorView()
        return view
    }()
    
    override func loadView() {
        view = screen.view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setFrameWindow(CGRect(x: 90, y: 215, width: 230, height: 390))
        setEnabledDraggable(true)
        configDelegate()
        configNumberFormatter()
    }
    
    override func viewDidSelectFloatView() {
        super.viewDidSelectFloatView()
        setShadow()
    }
    
    override func viewDidDeselectFloatView() {
        super.viewDidDeselectFloatView()
        removeShadow()
    }
    
    
    //  MARK: - Private Area
    private func configNumberFormatter() {
        self.numberFormatter
            .setNumberStyle(.decimal)
            .setMinimumFractionDigits(0)
            .setMaximumFractionDigits(5)
            .removeGroupingSeparator()
    }
    
    private func configDelegate() {
        screen.delegate = self
        screen.buttonsView.delegate = self
    }
    
    private func setShadow() {
        Utils.setShadowActiveFloatView(screen)
    }
    
    private func removeShadow() {
        Utils.removeShadowActiveFloatView(screen)
    }
    
    private func setDisplay(_ number: String) {
        if let numberDisplay = sanitizeDouble(number) {
            screen.display.setText(numberFormatter.getString(numberDisplay) ?? "0")
        }
    }
    
    private func setPlusMinus() {
        if !isPercentageTapped {
            finishedTypingNumber()
        }

        if var numberDisplay = sanitizeDouble(getDisplayValue()) {
            numberDisplay *= -1
            setDisplay("\(numberDisplay)")
            setNumberToCalculation()
        }
    }
    
    private func sanitizeDouble(_ number: String) -> Double? {
        return Double(number.replacingOccurrences(of: K.String.comma, with: K.String.dot))
    }
    
    private func configPercentage() {
        if isPercentageTapped { return }
        if isDisplayZero() {return}
        
        let operation = calc.operation
        let num1 = calc.previousValue
        let num2 = calc.currentValue
        
        var basePercentage = num1
        if operation != nil {
            basePercentage = num2
        }
        calc.previousValue = basePercentage
        calc.currentValue = 0.01
        setOperation(PercentageOperation())
        makeCalculation()
        
        if (operation is AdditionOperation) || (operation is SubtractionOperation) {
            calc.previousValue = num1
            calc.currentValue = calc.result
            setOperation(MultiplicationOperation())
            makeCalculation()
            
            calc.operation = operation
            calc.previousValue = num1
            calc.currentValue = calc.result
            makeCalculation()
        }
        
        if (operation is MultiplicationOperation) || (operation is DivisionOperation) {
            calc.previousValue = num1
            calc.currentValue = calc.result
            setOperation(operation)
            makeCalculation()
        }
        isPercentageTapped = true
    }
    
    private func setNumber(_ value: String) {
        isPercentageTapped = false
        setNumberOnDisplay(value)
        setNumberToCalculation()
    }
    
    private func setEquals() {
        makeCalculation()
    }
    
    private func getDisplayValue() -> String {
        if let display = screen.display.getText {
            return display
        }
        return K.String.zero
    }
    
    private func calculate() -> Double? {
        let result = calc.calculate
        if result == nil {
            calc.previousValue = Double(getDisplayValue())
        }
        return result
    }
    
    private func setBackspace() {
        if isDisplayZero() {return}
        
        let display = getDisplayValue()
        
        if display.count > 1 {
            let number = String(display.dropLast())
            screen.display.setText(number)
        }
        
        if display.count == 1 {
            calc.currentValue = nil
            clearDisplay()
        }
        return
    }
    
    private func resetCalculator() {
        calc.resetCalculation()
        calc.result = nil
        operation = nil
        isFinishedTypingNumber = true
        clearDisplay()
    }
    
    private func clearDisplay() {
        screen.display.setText(K.String.zero)
    }
    
    private func setDecimalSeparator() {
        finishedTypingNumber()
        screen.display.setText(getDisplayValue() + setDecimalSeparatorOnDisplay())
        setNumberToCalculation()
    }
       
    private func isDisplayZero() -> Bool {
        let display = getDisplayValue()
        if Double(display) == .zero {
            return true
        }
        return false
    }
    
    private func configDisplayWhenZero(_ value: String) {
        guard let display = Double(screen.display.getText ?? K.String.empty) else { return }
        
        if display.sign == .minus {
            screen.display.setText("-" + value)
        } else {
            screen.display.setText(value)
        }
    }
    
    private func finishedTypingNumber() {
        if isFinishedTypingNumber {
            clearDisplay()
            isFinishedTypingNumber = false
        }
    }
    
    private func setNumberOnDisplay(_ value: String) {
        finishedTypingNumber()
        
        if isDisplayZero() {
            configDisplayWhenZero(value)
            return
        }
        screen.display.setText(getDisplayValue() + value)
    }
    
    private func setDecimalSeparatorOnDisplay() -> String {
        isFinishedTypingNumber = false
        let display = getDisplayValue()
        if display.contains(NumberFormatterBuilder.get.decimalSeparator) { return K.String.empty }
        return NumberFormatterBuilder.get.decimalSeparator
    }
    
    private func setNumberToCalculation() {
        guard let numberDisplay = sanitizeDouble(getDisplayValue()) else {return}
        
        if operation == nil {
            calc.previousValue = numberDisplay
        } else {
            calc.currentValue = numberDisplay
        }
    }
    
    private func configCalculation(_ operation: CalculatorOperationProtocol) {
        if calc.previousValue == nil {
            calc.previousValue = Double(getDisplayValue())
        }
        makeCalculation()
        setOperation(operation)
    }
    
    private func setOperation(_ operation: CalculatorOperationProtocol?) {
        if let operation {
            self.operation = operation
            self.calc.operation = operation
        }
    }
    
    private func makeCalculation() {
        isFinishedTypingNumber = true
        if let result = calc.calculate {
            setDisplay("\(result)")
            operation = nil
            calc.previousValue = result
        }
    }
    

}


//  MARK: - EXTENSION WeatherViewDelegate

extension CalculatorFloatViewController: CalculatorViewDelegate {
    
    func closeWindow() {
        self.dismiss()
    }
    
    func minimizeWindow() {
        self.minimize
    }
    
}


//  MARK: - EXTENSION CalculatorButtonsViewDelegate
extension CalculatorFloatViewController: CalculatorButtonPanelViewDelegate {
    
    func calculatorButton(_ button: CalculatorButtonPanelView.CalculatorButtons) {
        
        switch button {
            case .one:
                setNumber(K.String.one)

            case .two:
                setNumber(K.String.two)

            case .three:
                setNumber(K.String.three)

            case .four:
                setNumber(K.String.four)

            case .five:
                setNumber(K.String.five)

            case .six:
                setNumber(K.String.six)

            case .seven:
                setNumber(K.String.seven)

            case .eight:
                setNumber(K.String.eight)

            case .nine:
                setNumber(K.String.nine)

            case .zero:
                setNumber(K.String.zero)
            
            case .decimalSeparator:
                setDecimalSeparator()
            
            case .backspace:
                setBackspace()

            case .addition:
                configCalculation(AdditionOperation())

            case .subtraction:
                configCalculation(SubtractionOperation())
            
            case .multiplication:
                configCalculation(MultiplicationOperation())
            
            case .division:
                configCalculation(DivisionOperation())
            
            case .percentage:
                configPercentage()
            
            case .equals:
                setEquals()
            
            case .clear:
                resetCalculator()
        
            case .plusMinus:
                setPlusMinus()
                
        }
    }
    
}
