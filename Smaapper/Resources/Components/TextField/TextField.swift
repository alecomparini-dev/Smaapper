//
//  TextField_.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 24/05/23.
//

import UIKit


protocol TextFieldDelegate: AnyObject {
    func textFieldShouldBeginEditing(_ textField: TextField) -> Bool
    func textFieldDidBeginEditing(_ textField: TextField)
    func textFieldShouldEndEditing(_ textField: TextField) -> Bool
    func textFieldDidEndEditing(_ textField: TextField, reason: UITextField.DidEndEditingReason)
    func textField(_ textField: TextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    func textFieldDidChangeSelection(_ textField: TextField)
    func textFieldShouldClear(_ textField: TextField) -> Bool
    func textFieldShouldReturn(_ textField: TextField) -> Bool
}

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
    
    weak var delegateTextField: TextFieldDelegate?
    
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
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if let delegate = delegateTextField {
            if !delegate.textFieldShouldBeginEditing(self) {
                return false
            }
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        delegateTextField?.textFieldDidBeginEditing(self)
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if let delegate = delegateTextField {
            if !delegate.textFieldShouldEndEditing(self) {
                return false
            }
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        delegateTextField?.textFieldDidEndEditing(self, reason: reason)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let delegate = delegateTextField {
            if !delegate.textField(self, shouldChangeCharactersIn: range, replacementString: string) {
                return false
            }
        }
        if self.keyboardType == .decimalPad {
            return validateKeyboardDecimal(string)
        }
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        delegateTextField?.textFieldDidChangeSelection(self)
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        if let delegate = delegateTextField {
            if !delegate.textFieldShouldClear(self) {
                return false
            }
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let delegate = delegateTextField {
            if !delegate.textFieldShouldReturn(self) {
                return false
            }
        }
        return true
    }
    
}


extension TextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: TextField) -> Bool {return true}
    func textFieldDidBeginEditing(_ textField: TextField) {}
    func textFieldShouldEndEditing(_ textField: TextField) -> Bool { return true}
    func textFieldDidEndEditing(_ textField: TextField, reason: TextField.DidEndEditingReason) { }
    func textField(_ textField: TextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool { return true}
    func textFieldDidChangeSelection(_ textField: TextField) {}
    func textFieldShouldClear(_ textField: TextField) -> Bool { return true}
    func textFieldShouldReturn(_ textField: TextField) -> Bool { return true}
    
    func textField(_ textField: TextField, editMenuForCharactersIn range: NSRange, suggestedActions: [UIMenuElement]) -> UIMenu? { return nil}
    @available(iOS 16.0, *)
    func textField(_ textField: TextField, willPresentEditMenuWith animator: UIEditMenuInteractionAnimating) {}
    @available(iOS 16.0, *)
    func textField(_ textField: TextField, willDismissEditMenuWith animator: UIEditMenuInteractionAnimating) {}
}

