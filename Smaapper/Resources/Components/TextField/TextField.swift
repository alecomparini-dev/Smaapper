//
//  TextField_.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 24/05/23.
//

import UIKit

class TextField: UITextField {
    
    enum Position {
         case left
         case right
     }
    
    static private var currentMainWindow: UIWindow?
    static private func hideKeyboardWhenViewTapped() {
        let mainWindow = CurrentWindow.window
        if (mainWindow == currentMainWindow) { return }
        mainWindow?.hideKeyboardWhenViewTapped()
        CurrentWindow.rootView?.hideKeyboardWhenViewTapped()
        currentMainWindow = mainWindow
    }
    
    init() {
        super.init(frame: .zero)
        addHideKeyboardWhenTouchReturn()
        delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        Resize.resize(self)
    }
    
    
//  MARK: - ACTIONS THIS COMPONENT
    
    private func validateKeyboardDecimal(_ character: String) -> Bool {
        guard let text = self.text else { return true}
        let numberFormatter = NumberFormatter()
        let decimalSeparator = numberFormatter.decimalSeparator ?? ""
        if character == decimalSeparator {
            return !text.contains(decimalSeparator)
        }
        return true
    }
    
    private func addHideKeyboardWhenTouchReturn(){
        self.addTarget(self, action: #selector(textFieldEditingDidEndOnExit), for: .editingDidEndOnExit)
        TextField.hideKeyboardWhenViewTapped()
    }
    
    @objc
    func textFieldEditingDidEndOnExit(_ textField: UITextField) {
        textField.resignFirstResponder()
    }
    
}

//  MARK: - EXTENSION
extension TextField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if self.keyboardType == .decimalPad {
            return validateKeyboardDecimal(string)
        }
        return true
    }
    
}

