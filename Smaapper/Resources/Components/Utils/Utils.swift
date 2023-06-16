//
//  Utils.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 15/06/23.
//

import UIKit

class Utils {
    
    static var decimalSeparator: String {
        if let decimalSeparator = Locale.current.decimalSeparator {
            return decimalSeparator
        }
        let numberFormatter = NumberFormatter()
        return numberFormatter.decimalSeparator
    }
    
    static var groupingSeparator: String {
        if let groupingSeparator = Locale.current.groupingSeparator {
            return groupingSeparator
        }
        let numberFormatter = NumberFormatter()
        return numberFormatter.groupingSeparator
    }
    
    static var currentWindow: UIWindow? {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let mainWindow = windowScene.windows.first {
            return mainWindow
        }
        return nil
    }
    
    static var rootView: UIView? {
        if let rootView = CurrentWindow.window?.rootViewController?.view {
            return rootView
        }
        return nil
    }
    
    static func allTextFieldsInView(_ view: UIView) -> [UITextField] {
        var textFields: [UITextField] = []
        view.subviews.forEach { subview in
            if let textField = subview as? UITextField {
                textFields.append(textField)
            } else {
                textFields += Utils.allTextFieldsInView(subview)
            }
        }
        return textFields
    }
    
    static func validatePercent(_ percent: CGFloat) -> Bool {
        if !(0.0...100.0).contains(percent) {
            return false
        }
        return true
    }
    
}
