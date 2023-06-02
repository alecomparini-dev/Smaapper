//
//  FloatWindowManagerActions.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 02/06/23.
//

import UIKit

class FloatWindowManagerActions {
    typealias closureEmptyAlias = () -> Void
    
    private var _allClosedWindow: [closureEmptyAlias] = []
    
    init() {
        configDelegate()
    }
    
    
//  MARK: - SET Actions
    @discardableResult
    func setAllClosedWindow(_ closure: @escaping closureEmptyAlias) -> Self {
        self._allClosedWindow.append(closure)
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
        self._allClosedWindow.forEach({ closure in
            closure()
        })
    }
    
    
}

