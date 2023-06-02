//
//  FloatWindowsActions.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 01/06/23.
//

import UIKit


class FloatWindowsActions: BaseActions {
    typealias floatWindowAlias = (_ floatWindow: FloatWindowViewController) -> Void
    
    private var _dismiss: floatWindowAlias?
    
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
    func setCloseWindow(_ closure: (@escaping floatWindowAlias)) -> Self {
        self._dismiss = closure
        return self
    }
    
    @discardableResult
    func setOpenWindow(_ closure: (@escaping floatWindowAlias)) -> Self {
        self._dismiss = closure
        return self
    }
    
    
    
//  MARK: - PRIVATE Area
    private func configTapGestureDelegate() {
        floatWindow.delegate = self
    }
    
    
}


//  MARK: - EXTENSION FloatWindowDelegate
extension FloatWindowsActions: FloatWindowDelegate {
    func dismiss(_ floatWindow: FloatWindowViewController) {
        self._dismiss?(floatWindow)
    }
    
    
}
