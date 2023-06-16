//
//  ProportionFloatViewController.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 12/06/23.
//

import UIKit

class ProportionFloatViewController: FloatViewController {
    static let identifierApp = "proportion"
    
    private var proportionA: Double = 0.0
    private var proportionB: Double = 0.0
    private var proportionC: Double = 0.0
    private var resultProportion: Double = 0.0
    
    lazy var screen: ProportionView = {
        let view = ProportionView()
        return view
    }()
    
    override func loadView() {
        view = screen.view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setFrameWindow(CGRect(x: 50, y: 150, width: 290, height: 180))
        setEnabledDraggable(true)
        configDelegate()
    }
    
    override func viewDidSelectFloatView() {
        super.viewDidSelectFloatView()
        UtilsFloatView.setShadowActiveFloatView(screen)
    }
    
    override func viewDidDeselectFloatView() {
        super.viewDidDeselectFloatView()
        UtilsFloatView.removeShadowActiveFloatView(screen)
    }
    
    
//  MARK: - PRIVATE Area
    
    private func configDelegate() {
        screen.delegate = self
        screen.setTextFieldDelegate(self)
        screen.setPainelDelegate(self)
    }
    
    private func calculateResult() {
        getNumbersForCalculate()
        if !isValidFields() {
            presentResult(0)
            return
        }
        let result = (proportionC * proportionB) / proportionA
        presentResult(result)
    }
    
    private func presentResult(_ result: Double) {
        if result == .zero {
            screen.painel.resultLabel.setText("0.0")
            return
        }
        let formattedResult = NumberFormatterBuilder().setMaximumFractionDigits(4).getString(result)
        screen.painel.resultLabel.setText(formattedResult ?? "0.0")
    }
    
    private func isValidFields() -> Bool {
        if isFieldsEmpty() || proportionA == .zero {
            return false
        }
        return true
    }
    
    
    private func isFieldsEmpty() -> Bool {
        if let textFieldEmpty = screen.painel.listTextFields.first(where: { ($0.text?.isEmpty) ?? false }) {
            textFieldEmpty.becomeFirstResponder()
            return true
        }
        return false
    }
    
    private func getNumbersForCalculate() {
        proportionA = screen.painel.textFieldA.getNumber.doubleValue
        proportionB = screen.painel.textFieldB.getNumber.doubleValue
        proportionC = screen.painel.textFieldC.getNumber.doubleValue
    }
    
    private func getDoubleValueOfTextField(_ text: String?) -> Double {
        if var textResult = text {
            if Utils.decimalSeparator != "." {
                textResult = textResult.replacingOccurrences(of: ".", with: "")
            }
            return Double(textResult.replacingOccurrences(of: Utils.decimalSeparator, with: ".")) ?? 0.0
        }
        return 0.0
    }
    
}


//  MARK: - EXTENSIONWeatherViewDelegate

extension ProportionFloatViewController: ProportionViewDelegate {

    func closeWindow() {
        self.dismiss()
    }
    
    func minimizeWindow() {
        self.minimize
    }
    
    func okButton() {
        calculateResult()
    }


}


//  MARK: - EXTENSION TextFieldDelegate
extension ProportionFloatViewController: TextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: TextField) {
        self.select
    }
    
}


//  MARK: - EXTENSION PainelProportionViewDelegate
extension ProportionFloatViewController: PainelProportionViewDelegate {
    
    func doneKeyboard(_ textField: UITextField) {
        calculateResult()
        self.view.endEditing(true)
    }
    
    
}
