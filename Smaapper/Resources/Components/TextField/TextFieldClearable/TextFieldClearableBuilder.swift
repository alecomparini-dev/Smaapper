//
//  TextFieldClearableBuilder.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 05/07/23.
//

import UIKit

class TextFieldClearableBuilder: TextFieldImageBuilder {
    
    init(paddingRightImage: CGFloat = C.TextField.Clearable.paddingRight) {
        super.init(
            image:
                ImageViewBuilder(UIImage(systemName: C.TextField.Clearable.Images.clearText))
                .setTintColor(Theme.shared.currentTheme.onSurfaceVariant)
                .setSize(C.TextField.Clearable.Images.clearTextSize)
                .view,
                   position: .right,
                   margin: paddingRightImage)
        initialization()
    }
    
    convenience init(_ placeHolder: String) {
        self.init()
        super.setPlaceHolder(placeHolder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialization() {
        configClearTextTapped()
        configDelegate()
        setHideImage(true)
    }
    
    
//  MARK: - PRIVATE Area
    private func configClearTextTapped() {
        self.setActions { build in
            build
                .setTouchImage { [weak self] _,_ in
                    self?.clearTextTapped()
                }
        }
    }
    
    private func configDelegate() {
        super.setDelegate(self)
    }
    
    
//  MARK: - ACTIONS THIS COMPONENT

    private func clearTextTapped() {
        super.setText(K.String.empty)
        super.setHideImage(true)
    }
    
}

//  MARK: - EXTENSION TextFieldDelegate
extension TextFieldClearableBuilder: TextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: TextField) {
        if (textField.text?.isEmpty ?? true) {
            super.setHideImage(true)
            return
        }
        super.setHideImage(false)
    }
    
    
    
}
