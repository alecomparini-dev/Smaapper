//
//  TextFieldConfigKeyboard.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 14/06/23.
//

import UIKit


class TextFieldConfigKeyboard {
    typealias callBackListTextFieldsAlias = () -> [UITextField]
    typealias completionKeyboardAlias = (_ textField: UITextField) -> Void

    enum NavigationTextField {
        case next
        case previous
    }
    static private let keyboardTypeWithOutReturn: [UIKeyboardType] = [.decimalPad, .asciiCapableNumberPad, .numberPad, .twitter, .phonePad]
    
    private var completionDoneKeyboard: completionKeyboardAlias?
    private var callBackListTextFields: callBackListTextFieldsAlias?
    
    private var isDoneButtonAlreadyIncluded = false
    private var toolbar: UIToolbar?
    
    private weak var textField: TextField?
    
    init(_ textField: TextField) {
        self.textField = textField
    }
    
//  MARK: - SET Properties
    
    @discardableResult
    func setKeyboardType(_ keyboardType: UIKeyboardType) -> Self {
        textField?.keyboardType = keyboardType
        createToolbar()
        if completionDoneKeyboard == nil {
            addAutomaticButtonOk()
        }
        return self
    }
    
    @discardableResult
    func setDoneButton(_ completion: @escaping completionKeyboardAlias) -> Self {
        completionDoneKeyboard = completion
        if isDoneButtonAlreadyIncluded {return self}
        isDoneButtonAlreadyIncluded = true
        createToolbar()
        addButtonItemToToolbar(UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonTapped)))
        return self
    }
    
    @discardableResult
    func setClearButton() -> Self {
        createToolbar()
        addButtonItemToToolbar(createClearButtonItem())
        addButtonItemToToolbar(createFixedSpace(10))
        return self
    }
    
    @discardableResult
    func setNavigationButtonTextField(_ callBackListTextFields: @escaping callBackListTextFieldsAlias ) -> Self {
        createToolbar()
        addNavigationsButtons()
        self.callBackListTextFields = callBackListTextFields
        return self
    }

    @discardableResult
    func setButtons(_ barButtonSystemItem: [UIBarButtonItem]) -> Self {
        createToolbar()
        return self
    }
    
    @discardableResult
    func setKeyboardAppearance(_ appearance: UIKeyboardAppearance) -> Self {
        textField?.keyboardAppearance = appearance
        return self
    }
    
    
//  MARK: - PRIVATE Area
    
    private func createFixedSpace(_ space: CGFloat) -> UIBarButtonItem {
        let fixedSpace = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        fixedSpace.width = space
        return fixedSpace
    }
    
    private func createClearButtonItem() -> UIBarButtonItem{
        let img = UIImage(systemName: "eraser.line.dashed")?.applyingSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 14))
        return UIBarButtonItem(image: img, style: .plain, target: self, action: #selector(clearButtonTapped))
    }
    
    private func addNavigationsButtons() {
        let imgPrevious = UIImage(systemName: "chevron.backward")
        let previous = UIBarButtonItem(image: imgPrevious, style: .plain, target: self, action: #selector(navigationPreviousButtonTapped))
        let imgNext = UIImage(systemName: "chevron.forward")
        let next = UIBarButtonItem(image: imgNext, style: .plain, target: self, action: #selector(navigationNextButtonTapped))
        addButtonItemToToolbar(previous)
        addButtonItemToToolbar(createFixedSpace(10))
        addButtonItemToToolbar(next)
        addButtonItemToToolbar(createFixedSpace(10))
    }
    
    private func addAutomaticButtonOk() {
        if isDoneButtonAlreadyIncluded {return}
        guard let keyboardType = textField?.keyboardType else {return}
        if TextFieldConfigKeyboard.keyboardTypeWithOutReturn.contains(keyboardType) {
            self.setDoneButton { [weak self] textField in
                guard let self else {return}
                self.textField?.textFieldEditingDidEndOnExit(textField)
            }
        }
    }
    
    private func createToolbar() {
        if toolbar != nil {return}
        toolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        configToolbar()
        addToolbarToTextField()
        addButtonItemToToolbar(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil))
    }
    
    private func configToolbar() {
        toolbar?.items = []
        toolbar?.barStyle = .default
        toolbar?.sizeToFit()
    }
    
    private func addToolbarToTextField() {
        self.textField?.inputAccessoryView = toolbar
    }
    
    private func addButtonItemToToolbar(_ barButtonItem: UIBarButtonItem) {
        guard let toolbar else {return}
        setColorToolbarItems(barButtonItem)
        toolbar.items?.append(barButtonItem)
        repositionDoneButtonToFirstPosition()
    }
    
    private func setColorToolbarItems(_ barButtonItem: UIBarButtonItem) {
        if textField?.keyboardAppearance == .dark {
            barButtonItem.tintColor = Theme.shared.currentTheme.onSurface
        } else {
            barButtonItem.tintColor = Theme.shared.currentTheme.onSurfaceInverse
        }
    }
    
    private func repositionDoneButtonToFirstPosition() {
        if let indexDone = toolbar?.items?.firstIndex(where: { $0.style == .done }) {
            let itemDone = toolbar?.items?[indexDone]
            toolbar?.items?.remove(at: indexDone)
            if let itemDone {toolbar?.items?.append(itemDone)}
        }
    }
    
    
//  MARK: - NAVIAGATION Area
    
    private func moveNextTextField(_ textField: UITextField) {
        guard let listTextFields = callBackListTextFields?() else {return}
        guard let currentIndex = listTextFields.firstIndex(of: textField) else {return}
        let nextIndex = currentIndex + 1
        if nextIndex < listTextFields.count {
            let nextTextField = listTextFields[nextIndex]
            nextTextField.becomeFirstResponder()
        } else {
            listTextFields[0].becomeFirstResponder()
        }
    }
    
    private func movePreviousTextField(_ textField: UITextField) {
        guard let listTextFields = callBackListTextFields?() else {return}
        guard let currentIndex = listTextFields.firstIndex(of: textField) else {return}
        
        let nextIndex = currentIndex - 1
        if nextIndex < 0 {
            listTextFields[listTextFields.count-1].becomeFirstResponder()
        } else {
            let nextTextField = listTextFields[nextIndex]
            nextTextField.becomeFirstResponder()
        }
    }
    
    
//  MARK: - OBJC Area
    @objc private func doneButtonTapped() {
        guard let textField else {return}
        textField.textFieldEditingDidEndOnExit(textField)
        completionDoneKeyboard?(textField)
    }
    
    @objc private func navigationNextButtonTapped() {
        guard let textField else {return}
        moveNextTextField(textField)
    }
    
    @objc private func navigationPreviousButtonTapped() {
        guard let textField else {return}
        movePreviousTextField(textField)
    }
    
    @objc private func clearButtonTapped() {
        guard let textField else {return}
        textField.text = ""
    }
    
}
