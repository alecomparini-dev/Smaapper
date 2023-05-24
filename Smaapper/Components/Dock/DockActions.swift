//
//  DockActions.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 23/05/23.
//

import Foundation

class DockActions {
    
    typealias touchDockClosureAlias = (_ indexItem: Int ) -> Void
    typealias showDockClosureAlias = (_ stateDock: Dock.State) -> Void
    typealias hideDockClosureAlias = (_ stateDock: Dock.State) -> Void
    
    private var _touchDockClosure: touchDockClosureAlias?
    private var _showDockClosure: showDockClosureAlias?
    private var _hideDockClosure: hideDockClosureAlias?
    
    private let dock: Dock
    
    init(_ dock: Dock) {
        self.dock = dock
    }

//  MARK: - GET Propeties
    var touchDockClosure: touchDockClosureAlias? { self._touchDockClosure}
    var showDockClosure: showDockClosureAlias? { self._showDockClosure}
    var hideDockClosure: hideDockClosureAlias? { self._hideDockClosure}
    
    
//  MARK: - SET Actions
    
    @discardableResult
    func setEvent(touch closure: @escaping touchDockClosureAlias) -> Self {
        self._touchDockClosure = closure
        return self
    }
    
    @discardableResult
    func setEvent(openMenu closure: @escaping showDockClosureAlias) -> Self {
        self._showDockClosure = closure
        return self
    }
    
    @discardableResult
    func setEvent(closeMenu closure: @escaping hideDockClosureAlias) -> Self {
        self._hideDockClosure = closure
        return self
    }
    
    
    
}
