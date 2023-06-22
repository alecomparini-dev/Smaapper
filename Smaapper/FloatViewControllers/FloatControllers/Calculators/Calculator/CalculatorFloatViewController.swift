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
        UtilsFloatView.setShadowActiveFloatView(screen)
    }
    
    private func removeShadow() {
        UtilsFloatView.removeShadowActiveFloatView(screen)
    }
    
    private func setPlusMinus() {
        if var numberDisplay = sanitizeDouble(getDisplayValue) {
            numberDisplay *= -1
            screen.display.setText(numberFormatter.getString(numberDisplay) ?? "0")
        }
    }
    
    private func sanitizeDouble(_ number: String) -> Double? {
        return Double(number.replacingOccurrences(of: ",", with: "."))
    }
    
    private func configPercentage() {
        isFinishedTypingNumber = true
        if isPercentageTapped { return }
        if isDisplayZero() {return}
        
        let operation = calc.operation
        let num1 = calc.previousValue
        let num2 = calc.currentValue
        
        //Calculando Percentagem
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
    
    private var getDisplayValue: String {
        if let display = screen.display.getText {
            return display
        }
        return "0"
    }
    
    private func calculate() -> Double? {
        let result = calc.calculate
        if result == nil {
            calc.previousValue = Double(getDisplayValue)
        }
        return result
    }
    
    private func setBackspace() {
        if isDisplayZero() {return}
        
        let display = getDisplayValue
        
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
        screen.display.setText("0")
    }
    
    private func setDecimalSeparator() {
        screen.display.setText(getDisplayValue + setDecimalSeparatorOnDisplay())
    }
       
    private func isDisplayZero() -> Bool {
        let display = screen.display.getText ?? "0"
        if Double(display) == 0 {
            return true
        }
        return false
    }
    
    private func configDisplayWhenZero(_ value: String) {
        guard let display = Double(screen.display.getText ?? "") else { return }
        
        if display.sign == .minus {
            screen.display.setText("-" + value)
        } else {
            screen.display.setText(value)
        }
        
        if value == NumberFormatterBuilder.get.decimalSeparator {
            let valueFormatted = setDecimalSeparatorOnDisplay()
            screen.display.setText(getDisplayValue + valueFormatted)
        }
    }
    
    private func setNumberOnDisplay(_ value: String) {
        if isFinishedTypingNumber {
            screen.display.setText(value)
            isFinishedTypingNumber = false
            return
        }
        
        if isDisplayZero() {
            configDisplayWhenZero(value)
            return
        }
        
        screen.display.setText(getDisplayValue + value)

    }
    
//    private func isInt(_ value: String) -> Bool {
//        if let number = Double(value) {
//            return floor(number) == number
//        }
//        return false
//    }
    
    private func setDecimalSeparatorOnDisplay() -> String {
        isFinishedTypingNumber = false
        let display = getDisplayValue
        if display.contains(NumberFormatterBuilder.get.decimalSeparator) { return "" }
        return NumberFormatterBuilder.get.decimalSeparator
    }
    
    private func setNumberToCalculation() {
        guard let numberDisplay: Double = Double(getDisplayValue) else {return}
        if operation == nil {
            calc.previousValue = numberDisplay
        } else {
            calc.currentValue = numberDisplay
        }
    }
    
    private func configCalculation(_ operation: CalculatorOperationProtocol) {
        if calc.previousValue == nil {
            calc.previousValue = Double(getDisplayValue)
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
        if let result = calc.calculate {
            if result == floor(result) {
                screen.display.setText("\(Int(result))")
            } else {
                screen.display.setText("\(result)")
            }
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
extension CalculatorFloatViewController: CalculatorButtonsViewDelegate {
    
    func calculatorButton(_ button: CalculatorButtonsView.CalculatorButtons) {
        
        switch button {
            case .one:
                setNumber("1")

            case .two:
                setNumber("2")

            case .three:
                setNumber("3")

            case .four:
                setNumber("4")

            case .five:
                setNumber("5")

            case .six:
                setNumber("6")

            case .seven:
                setNumber("7")

            case .eight:
                setNumber("8")

            case .nine:
                setNumber("9")

            case .zero:
                setNumber("0")
            
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
                break
            
            case .clear:
                resetCalculator()
                break
        
            case .plusMinus:
                setPlusMinus()
                break
                
        }
    }
    
}
