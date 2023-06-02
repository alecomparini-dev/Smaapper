//
//  FloatWindowManagerActions.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 02/06/23.
//

import UIKit

class FloatWindowManagerActions {
    typealias closureEmptyAlias = () -> Void
    
    private var allClosedWindow: [closureEmptyAlias] = []
    
    init() {
        configDelegate()
    }
    
    
//  MARK: - SET Actions
    @discardableResult
    func setAllClosedWindow(_ closure: @escaping closureEmptyAlias) -> Self {
        self.allClosedWindow.append(closure)
        return self
    }
    
    
//  MARK: - PRIVATE Area
    private func configDelegate() {
        FloatWindowManager.instance.delegate = self
    }

}


//  MARK: - EXTENSION FloatWindowManagerDelegate
extension FloatWindowManagerActions: FloatWindowManagerDelegate {
    
    func allClosedWindows() {
        self.allClosedWindow.forEach({ closure in
            closure()
        })
    }
    
    
}

