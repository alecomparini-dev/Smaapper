//
//  FontViewModel.swift
//  BackFront-BFNFT
//
//  Created by Alessandro Comparini on 23/03/23.
//

import UIKit

class FontViewModel {
    
    private var model: FontModel
    
    init(_ font: FontModel) {
        self.model = font
    }
    
    var size: CGFloat {
        get { model.size }
        set { model.size = newValue }
    }
    
    var name: String {
        get { model.name }
        set { model.name = newValue }
    }
    
    var weight: UIFont.Weight {
        get { model.weight }
        set { model.weight = newValue }
    }
    
    
     
    func systemFont() -> UIFont {
        return UIFont.systemFont(ofSize: model.size, weight: model.weight)
    }
    
    func customFont() -> UIFont {
        return validateFontNameBuilding()
    }
    
    
    private func validateFontNameBuilding() -> UIFont {
        
        if model.name.isEmpty {
            debugPrint("Font Name is Empty!")
            return systemFont()
        }
        
        guard let fontName = UIFont(name: model.name, size: model.size) else {
            preconditionFailure("\(model.name) font is not valid!")
        }
        return fontName
    }
    
}
