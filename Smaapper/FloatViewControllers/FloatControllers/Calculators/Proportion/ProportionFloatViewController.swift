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
    }
    
    private func calculateResult() {
        getNumbersForCalculate()
        if !isValidFields() { return }
        let result = (proportionC * proportionB) / proportionA
        presentResult(result)
    }
    
    private func presentResult(_ result: Double) {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 5
        if let formattedString = formatter.string(from: NSNumber(value: result)) {
            screen.painel.resultLabel.setText(formattedString)
        }
    }
    
    private func isValidFields() -> Bool {
//        let alert = Alert(controller: home, title: "Number Incorrect", message: "Number 65. Incorrect", typeAlert: Warning())
//        alert.present()
        return true
    }
    
    private func getNumbersForCalculate() {
    
        if let text = screen.painel.textFieldA.view.text {
            self.proportionA = getDoubleValueOfTextField(text)
        }
        
        if let text = screen.painel.textFieldB.view.text {
            self.proportionB = getDoubleValueOfTextField(text)
        }
        
        if let text = screen.painel.textFieldC.view.text {
            self.proportionC = getDoubleValueOfTextField(text)
        }
    }
    
    private func getDoubleValueOfTextField(_ text: String) -> Double {
        var textResult = text
        if Utils.decimalSeparator != "." {
            textResult = textResult.replacingOccurrences(of: ".", with: "")
        }
        textResult = textResult.replacingOccurrences(of: Utils.decimalSeparator, with: ".")
        return Double(textResult) ?? 0
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
