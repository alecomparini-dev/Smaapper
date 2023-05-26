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
    
    private(set) var touchDockClosure: touchDockClosureAlias?
    private(set) var showDockClosure: eventDockClosureAlias?
    private(set) var hideDockClosure: eventDockClosureAlias?
    
    private let dock: Dock
    
    init(_ dock: Dock) {
        self.dock = dock
    }

    
//  MARK: - SET Actions
    
    @discardableResult
    func setAction(touch closure: @escaping touchDockClosureAlias) -> Self {
        self.touchDockClosure = closure
        return self
    }
    
    @discardableResult
    func setAction(event: Event  ,closure: @escaping eventDockClosureAlias) -> Self {
        switch event {
            case .showDock:
                self.showDockClosure = closure
            case .hideDock:
                self.hideDockClosure = closure
        }
        return self
    }
    
    
}
