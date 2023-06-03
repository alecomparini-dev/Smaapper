//
//  FloatWindowsActions.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 01/06/23.
//

import UIKit


class FloatWindowsActions: BaseActions {
    typealias floatWindowAlias = (_ floatWindow: FloatWindowViewController) -> Void
    
    private var _closeWindow: [floatWindowAlias] = []
    
    private let floatWindow: FloatWindowViewController
    
    init(_ floatWindow: FloatWindowViewController) {
        self.floatWindow = floatWindow
        super.init(floatWindow)
        self.initialization()
    }
    
    private func initialization() {
        configTapGestureDelegate()
    }
    
    
//  MARK: - SET Actions
    @discardableResult
    func setCloseWindow(_ closure: @escaping floatWindowAlias) -> Self {
        self._closeWindow.append(closure)
        return self
    }
    
    
//  MARK: - PRIVATE Area
    private func configTapGestureDelegate() {
        floatWindow.delegate = self
    }
    
}


//  MARK: - EXTENSION FloatWindowDelegate
extension FloatWindowsActions: FloatWindowDelegate {

    func closeWindow(_ floatWindow: FloatWindowViewController) {
        self._closeWindow.forEach({ closure in
            closure(floatWindow)
        })
    }
    

    
}
