//
//  GetCurrentWindow.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 23/05/23.
//

import UIKit

class CurrentWindow {
    
    static var get: UIWindow? {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let mainWindow = windowScene.windows.first {
            return mainWindow
        }
        return nil
    }
    
    static var rootView: UIView? {
        if let rootView = CurrentWindow.get?.rootViewController?.view {
            return rootView
        }
        return nil
    }
    
    
}
