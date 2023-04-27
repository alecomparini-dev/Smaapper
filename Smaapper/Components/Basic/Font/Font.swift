//
//  Font.swift
//  BackFront-BFNFT
//
//  Created by Alessandro Comparini on 23/03/23.
//

import UIKit

class Font {
    
    private let fontVM: FontViewModel
    
    init() {
        self.fontVM = FontViewModel(FontModel())
    }
    
    init(_ size: CGFloat) {
        self.fontVM = FontViewModel(FontModel(size: size))
    }

    var getSize: CGFloat { fontVM.size }
    func setSize(_ value: CGFloat) -> Self {
        fontVM.size = value
        return self
    }
    
    func setName(_ value: String) -> Self {
        fontVM.name = value
        return self
    }
    
    var getWeight: UIFont.Weight { fontVM.weight }
    func setWeight(_ value: UIFont.Weight) -> Self {
        fontVM.weight = value
        return self
    }
    
    
    func build() -> UIFont {
        if !fontVM.name.isEmpty {
            return fontVM.customFont()
        }
        return fontVM.systemFont()
    }
    
    
}
