//
//  UtilsComponent.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 15/06/23.
//

import UIKit

class UtilsComponent {
    
    struct Validate {
        static func percent(_ percent: CGFloat) -> Bool {
            if !(0.0...100.0).contains(percent) {
                return false
            }
            return true
        }
    }
    

//  MARK: - WINDOW
    struct Window {
        static var currentWindow: UIWindow? {
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let mainWindow = windowScene.windows.first {
                return mainWindow
            }
            return nil
        }
        
        static var rootView: UIView? {
            if let rootView = UtilsComponent.Window.currentWindow?.rootViewController?.view {
                return rootView
            }
            return nil
        }
    }
    
    
//  MARK: - TEXTFIELD
    struct TextField {
        static func allTextFieldsInView(_ view: UIView) -> [UITextField] {
            var textFields: [UITextField] = []
            view.subviews.forEach { subview in
                if let textField = subview as? UITextField {
                    textFields.append(textField)
                } else {
                    textFields += UtilsComponent.TextField.allTextFieldsInView(subview)
                }
            }
            return textFields
        }
    }
    
    
}
