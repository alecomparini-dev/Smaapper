//
//  DockActions.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 23/05/23.
//

import Foundation

class DockActions {
    
    enum EventDock {
        case showDock
        case hideDock
    }
    
    enum EventItemDock {
        case activatedItem
        case deactivatedItem
    }
    
    typealias indexItemDockAlias = (_ indexItem: Int ) -> Void
    typealias eventDockClosureAlias = (_ stateDock: EventDock) -> Void
    
    private(set) var touchItemDock: indexItemDockAlias?
    private(set) var showDockClosure: eventDockClosureAlias?
    private(set) var hideDockClosure: eventDockClosureAlias?
    private(set) var activatedItemDock: indexItemDockAlias?
    private(set) var deactivatedItemDock: indexItemDockAlias?
    
    private let dock: Dock
    
    init(_ dock: Dock) {
        self.dock = dock
    }

    
//  MARK: - SET Actions
    
    @discardableResult
    func setTouchItem(_ closure: @escaping indexItemDockAlias) -> Self {
        self.touchItemDock = closure
        return self
    }
    
    @discardableResult
    func setEventDock(event: EventDock, closure: @escaping eventDockClosureAlias) -> Self {
        switch event {
            case .showDock:
                self.showDockClosure = closure
            
            case .hideDock:
                self.hideDockClosure = closure
        }
        return self
    }
    
    @discardableResult
    func setEventItemDock(event: EventItemDock, closure: @escaping indexItemDockAlias) -> Self {
        switch event {
            case .activatedItem:
                self.activatedItemDock = closure
            
            case .deactivatedItem:
                self.deactivatedItemDock = closure
        }
        
        return self
    }
    
    
}
