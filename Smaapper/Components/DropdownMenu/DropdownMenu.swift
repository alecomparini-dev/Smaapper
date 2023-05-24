//
//  DropdownMenu_.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 24/05/23.
//

import UIKit


class DropdownMenu: UIView {
    
    enum PositionMenu {
        case leftTop
        case leftBottom
        case rightTop
        case rightBottom
    }
    
    enum StateMenu {
        case open
        case close
    }
    
    private var _positionOpenMenu: DropdownMenu.PositionMenu = .rightBottom
    private var _menuHeight: CGFloat?
    private var _menuWidth: CGFloat?
    private var _paddingCells: UIEdgeInsets?
    private var _autoCloseEnabled: Bool = false
    private var _excludeComponents: [UIView] = []
    private var _paddingMenu: UIEdgeInsets?
    
    
//  MARK: - Lazy Properties
    
    lazy var list: List = {
        let list = List(.grouped)
            .setShowsVerticalScrollIndicator(false)
            .setSeparatorStyle(.none)
            .setSectionHeaderHeight(30)
            .setSectionFooterHeight(20)
            .setBackgroundColor(.clear)
        return list
    }()
    
    lazy var overlay: View = {
        let overlay = View()
            .setUserInteractionEnabled(false)
        overlay.makeBlur { make in
            make
                .setStyle(.systemUltraThinMaterialDark)
                .setStyle(.dark)
                .setOpacity(0.7)
                .apply()
        }
        return overlay
    }()
    

    
//  MARK: - GET Attributes

    var positionOpenMenu: DropdownMenu.PositionMenu {
        get { self._positionOpenMenu }
        set { self._positionOpenMenu = newValue }
    }
    
    var menuHeight: CGFloat? {
        get { self._menuHeight }
        set { self._menuHeight = newValue }
    }
    
    var menuWidth: CGFloat? {
        get { self._menuWidth }
        set { self._menuWidth = newValue }
    }
    
    var paddingCells: UIEdgeInsets? {
        get { self._paddingCells }
        set { self._paddingCells = newValue }
    }
    
    var autoCloseEnabled: Bool {
        get { self._autoCloseEnabled }
        set { self._autoCloseEnabled = newValue }
    }
    
    var excludeComponents: [UIView] {
        get { self._excludeComponents }
        set { self._excludeComponents = newValue }
    }
    
    var paddingMenu: UIEdgeInsets? {
        get { self._paddingMenu }
        set { self._paddingMenu = newValue }
    }
    
}
