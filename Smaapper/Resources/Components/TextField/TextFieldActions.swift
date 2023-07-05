//
//  TextFieldActions.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 05/07/23.
//

import UIKit


class TextFieldActions: BaseActions {
    
    private let textFieldBuilder: TextFieldBuilder
    
    init(_ textFieldBuilder: TextFieldBuilder) {
        self.textFieldBuilder = textFieldBuilder
        super.init(self.textFieldBuilder)
    }
    
    
    
}
