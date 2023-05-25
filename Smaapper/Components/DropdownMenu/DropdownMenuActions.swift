//
//  DropdownMenuAction.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 23/05/23.
//

import Foundation

class DropdownMenuActions {

    enum Event {
        case openMenu
        case closeMenu
    }

    typealias touchMenuClosureAlias = (_ rowTapped: (section: Int, row: Int)) -> Void
    typealias eventMenuClosureAlias = () -> Void
    
    private var _touchMenuClosure: touchMenuClosureAlias?
    private var _openMenuClosure: eventMenuClosureAlias?
    private var _closeMenuClosure: eventMenuClosureAlias?
    
    
//  MARK: - GET Actions
    
    var touchMenuClosure: touchMenuClosureAlias? { self._touchMenuClosure}
    var openMenuClosure: eventMenuClosureAlias? { self._openMenuClosure}
    var closeMenuClosure: eventMenuClosureAlias? { self._closeMenuClosure}
    
    
//  MARK: - SET Actions
    
    @discardableResult
    func setAction(touch closure: @escaping touchMenuClosureAlias) -> Self {
        self._touchMenuClosure = closure
        return self
    }
    
    @discardableResult
    func setAction(event: Event, closure: @escaping eventMenuClosureAlias) -> Self {
        switch event {
            case .openMenu:
                self._openMenuClosure = closure
            case .closeMenu:
                self._closeMenuClosure = closure
        }
        return self
    }
    
    
}

