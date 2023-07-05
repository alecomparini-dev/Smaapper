//
//  TextFieldImageActions.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 05/07/23.
//

import UIKit


class TextFieldImageActions: TextFieldActions {
    
    private let textFieldImageBuilder: TextFieldImageBuilder
    
    init(_ textFieldImageBuilder: TextFieldImageBuilder) {
        self.textFieldImageBuilder = textFieldImageBuilder
        super.init(self.textFieldImageBuilder)
    }
    
    
//  MARK: - Action Area
    @discardableResult
    func setTouchImage(_ closure: @escaping touchBaseActionAlias, _ cancelsTouchesInView: Bool = true) -> Self {
        textFieldImageBuilder.paddingView.makeTapGesture({ make in
            make
                .setCancelsTouchesInView(cancelsTouchesInView)
                .setTouchEnded { [weak self] tapGesture in
                    guard let self else {return}
                    closure(textFieldImageBuilder.imageView, tapGesture)
                }
        })
        return self
    }
    
}
