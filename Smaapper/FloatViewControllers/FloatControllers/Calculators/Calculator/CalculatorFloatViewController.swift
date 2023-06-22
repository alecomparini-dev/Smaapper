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
    private var isClearDisplay: Bool = false
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
        numberFormatter.usesSignificantDigits = true
        numberFormatter.maximumSignificantDigits = 5
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
        var value = numberFormatter.getNumber(getDisplayValue)?.doubleValue ?? 0
        value = value * -1
        clearDisplay()
        setValue(numberFormatter.getString(value) ?? "0")
    }
    
    private func configPercentage() {
        isClearDisplay = true
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
    
    private func setValue(_ value: String) {
        isPercentageTapped = false
        configValueToDisplay(value)
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
    
    private var setBackspace: Void {
        if isDisplayZero() {return}
        let display = getDisplayValue
        clearDisplay()
        if display.count > 1 {
            configValueToDisplay(String(display.dropLast()))
        }
        if display.count == 1 {
            calc.currentValue = nil
        }
        return
    }
    
    private func resetCalculator() {
        calc.previousValue = nil
        calc.currentValue = nil
        calc.operation = nil
        operation = nil
        clearDisplay()
    }
    
    private func clearDisplay() {
        setValueOnDisplay("0")
    }
    
    private var setDecimalSeparator: Void {
        configValueToDisplay(",")
    }
       
    private func isDisplayZero() -> Bool {
        let display = screen.display.getText ?? "0"
        if Double(display) == 0 {
            return true
        }
        return false
    }
    
    private func setValueOnDisplay(_ value: String) {
        let decimalSeparator = NumberFormatterBuilder.get.decimalSeparator ?? "."
//        var valueFormatted = numberFormatter.getString(value) ?? "0"
//        if value.contains(decimalSeparator) {
//            valueFormatted = value
//        }
        
        screen.display.setText(value.replacingOccurrences(of: ".", with: NumberFormatterBuilder.get.decimalSeparator))
    }
    
    private func configValueToDisplay(_ value: String) {
        guard var display = screen.display.getText else { return }
        if isClearDisplay {
            clearDisplay()
            isClearDisplay = false
            display = ""
        }
        
        if isDisplayZero() {display = ""}
        
        if value == NumberFormatterBuilder.get.decimalSeparator {
            display += setDecimalSeparatorOnDisplay()
        } else {
            display += value
        }
        setValueOnDisplay(display)
    }
    
    private func setDecimalSeparatorOnDisplay() -> String {
        let display = screen.display.getText ?? ""
        if display.contains(NumberFormatterBuilder.get.decimalSeparator) { return "" }
        if isDisplayZero() {
            return "0\(NumberFormatterBuilder.get.decimalSeparator ?? ".")"
        }
        return NumberFormatterBuilder.get.decimalSeparator
    }
    
    private func setNumberToCalculation() {
        let numberDisplay: Double = numberFormatter.getNumber(getDisplayValue)?.doubleValue ?? 0
//        let numberDisplay: Double = Double(truncating: numberFormatter.getNumber(getDisplayValue) ?? 0)
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
        isClearDisplay = true
    }
    
    private func setOperation(_ operation: CalculatorOperationProtocol?) {
        if let operation {
            self.operation = operation
            self.calc.operation = operation
        }
    }
    
    private func makeCalculation() {
        if let result = calc.calculate {
            setValueOnDisplay("\(result)")
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
                setValue("1")

            case .two:
                setValue("2")

            case .three:
                setValue("3")

            case .four:
                setValue("4")

            case .five:
                setValue("5")

            case .six:
                setValue("6")

            case .seven:
                setValue("7")

            case .eight:
                setValue("8")

            case .nine:
                setValue("9")

            case .zero:
                setValue("0")
            
            case .decimalSeparator:
                setDecimalSeparator
            
            case .backspace:
                setBackspace

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
