//
//  DropdownMenu.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 01/05/23.
//

import UIKit


class DropdownMenu: View {
    
    enum PositionMenu {
        case leftTop
        case leftBottom
        case rightTop
        case rightBottom
    }
    
    private var positionOpenMenu: DropdownMenu.PositionMenu = .rightBottom
    private var menuHeight: Int = 250
    private var itemsHeight: Int = 35
    private var sections: [String] = []
    private var sectionItems: [String] = []
    private var subItems: [String] = []
    
    
//  MARK: - Set Properties
    
    func setPositionOpenMenu(_ position: DropdownMenu.PositionMenu) -> Self {
        self.positionOpenMenu = position
        return self
    }
    
    func setMenuHeight(_ height: Int) -> Self {
        self.menuHeight = height
        return self
    }
    
    func setItemsHeight(_ height: Int) -> Self {
        self.itemsHeight = height
        return self
    }
    
    func setSections() -> Self {
        
        return self
    }
    
    
    
    
////  MARK: - COMMON FUNCTIONS
//    func setShadow(_ shadow: (_ build: Shadow) -> Shadow )  -> Self {
//        let _ = shadow(Shadow(self))
//        return self
//    }

    
    
}
