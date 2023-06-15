//
//  AllTextFieldsInView.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 15/06/23.
//

import UIKit

struct AllTextFieldsInView {
    
    static func get(_ view: UIView) -> [UITextField] {
        var textFields: [UITextField] = []
        view.subviews.forEach { subview in
            if let textField = subview as? UITextField {
                textFields.append(textField)
            } else {
                textFields += AllTextFieldsInView.get(subview)
            }
        }
        return textFields
    }
    
}
