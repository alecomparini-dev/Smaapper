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
    
    private(set) var touchMenuClosure: touchMenuClosureAlias?
    private(set) var openMenuClosure: eventMenuClosureAlias?
    private(set) var closeMenuClosure: eventMenuClosureAlias?
    
        
//  MARK: - SET Actions
    
    @discardableResult
    func setAction(touch closure: @escaping touchMenuClosureAlias) -> Self {
        self.touchMenuClosure = closure
        return self
    }
    
    @discardableResult
    func setAction(event: Event, closure: @escaping eventMenuClosureAlias) -> Self {
        switch event {
            case .openMenu:
                self.openMenuClosure = closure
            case .closeMenu:
                self.closeMenuClosure = closure
        }
        return self
    }
    
    
}

