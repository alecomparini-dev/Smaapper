//
//  DockActions.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 23/05/23.
//

import Foundation

class DockActions {
    
    enum Event {
        case showDock
        case hideDock
    }
    
    typealias touchDockClosureAlias = (_ indexItem: Int ) -> Void
    typealias eventDockClosureAlias = (_ stateDock: Event) -> Void
    
    private var _touchDockClosure: touchDockClosureAlias?
    private var _showDockClosure: eventDockClosureAlias?
    private var _hideDockClosure: eventDockClosureAlias?
    
    private let dock: Dock
    
    init(_ dock: Dock) {
        self.dock = dock
    }

//  MARK: - GET Propeties
    var touchDockClosure: touchDockClosureAlias? { self._touchDockClosure}
    var showDockClosure: eventDockClosureAlias? { self._showDockClosure}
    var hideDockClosure: eventDockClosureAlias? { self._hideDockClosure}
    
    
//  MARK: - SET Actions
    
    @discardableResult
    func setAction(touch closure: @escaping touchDockClosureAlias) -> Self {
        self._touchDockClosure = closure
        return self
    }
    
    @discardableResult
    func setAction(event: Event  ,closure: @escaping eventDockClosureAlias) -> Self {
        switch event {
            case .showDock:
                self._showDockClosure = closure
            case .hideDock:
                self._hideDockClosure = closure
        }
        return self
    }
    
    
}
