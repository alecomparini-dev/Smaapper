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
    
    var touchMenuClosure: touchMenuClosureAlias?
    var openMenuClosure: openMenuClosureAlias?
    var closeMenuClosure: closeMenuClosureAlias?
    
    private let dropdowMenu: DropdownMenu
    
    init(_ dropdowMenu: DropdownMenu) {
        self.dropdowMenu = dropdowMenu
    }
    
    
//  MARK: - Actions
    
    @discardableResult
    func setEvent(touch closure: @escaping touchMenuClosureAlias) -> Self {
        self.touchMenuClosure = closure
        return self
    }
    
    @discardableResult
    func setEvent(openMenu closure: @escaping openMenuClosureAlias) -> Self {
        self.openMenuClosure = closure
        return self
    }
    
    @discardableResult
    func setEvent(closeMenu closure: @escaping closeMenuClosureAlias) -> Self {
        self.closeMenuClosure = closure
        return self
    }
    
}
