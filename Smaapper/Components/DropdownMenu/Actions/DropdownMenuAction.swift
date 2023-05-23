//
//  DropdownMenuAction.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 23/05/23.
//

import Foundation

class DropdownMenuAction {
    
    typealias touchMenuClosureAlias = ((_ rowTapped: (section: Int, row: Int)) -> Void)
    typealias openMenuClosureAlias = (_ stateMenu: DropdownMenu.StateMenu) -> Void
    typealias closeMenuClosureAlias = (_ stateMenu: DropdownMenu.StateMenu) -> Void
    
    private var _touchMenuClosure: touchMenuClosureAlias?
    private var _openMenuClosure: openMenuClosureAlias?
    private var _closeMenuClosure: closeMenuClosureAlias?
    
    
//  MARK: - GET Actions
    
    var touchMenuClosure: touchMenuClosureAlias? { self._touchMenuClosure}
    var openMenuClosure: openMenuClosureAlias? { self._openMenuClosure}
    var closeMenuClosure: closeMenuClosureAlias? { self._closeMenuClosure}
    
    
//  MARK: - SET Actions
    
    @discardableResult
    func setEvent(touch closure: @escaping touchMenuClosureAlias) -> Self {
        self._touchMenuClosure = closure
        return self
    }
    
    @discardableResult
    func setEvent(openMenu closure: @escaping openMenuClosureAlias) -> Self {
        self._openMenuClosure = closure
        return self
    }
    
    @discardableResult
    func setEvent(closeMenu closure: @escaping closeMenuClosureAlias) -> Self {
        self._closeMenuClosure = closure
        return self
    }
    
    
}
