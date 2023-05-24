//
//  DropdownMenu_.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 24/05/23.
//

import UIKit

class DropdownMenu_: UIView {
    
    private var _positionOpenMenu: DropdownMenu.PositionMenu = .rightBottom
    private var _menuHeight: CGFloat?
    private var _menuWidth: CGFloat?
    private var _paddingCells: UIEdgeInsets?
    private var _autoCloseEnabled: Bool = false
    private var _excludeComponents: [UIView] = []
    private var _paddingMenu: UIEdgeInsets?
    
    private var alreadyApplied = false
    private var _isShow = false
    private var zPosition: CGFloat = 10000
    
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
    

    var isShow: Bool {
        get {
            return self._isShow }
        set {
            self._isShow = newValue
            applyOnceConfig()
            isPresented()
            bringToFront()
        }
    }
    

    private func applyOnceConfig() {
        if self._isShow && !alreadyApplied {
            self.addListOnDropdownMenu()
            self.configDropDownMenuConstraints()
            self.configAutoCloseDropdownMenu()
            self.configOverlay()
            self.setHierarchyVisualizationPosition()
            self.alreadyApplied = true
        }
    }

    private func configOverlay() {
        addOverlayInDropdownMenu()
        configOverlayConstraints()
        setOverlayHierarchyVisualizationPosition()
    }
    
    private func configOverlayConstraints() {
        guard let superview = self.superview else {return}
        overlay.makeConstraints { make in
            make
                .setPin.equalTo(superview)
        }
    }
    
    private func addOverlayInDropdownMenu() {
        overlay.add(insideTo: self)
    }
    
    private func setHierarchyVisualizationPosition() {
        setDropdownHierarchyVisualizationPosition()
        setExcludeComponentsHierarchyVisualizationPosition()
    }
    
    private func setDropdownHierarchyVisualizationPosition() {
        self.layer.zPosition = zPosition
    }
    
    private func setExcludeComponentsHierarchyVisualizationPosition() {
        excludeComponents.forEach { comp in
            comp.layer.zPosition = self.zPosition + 1
        }
    }
    
    private func setOverlayHierarchyVisualizationPosition() {
        overlay.layer.zPosition = -1
    }
    
    
    private func configAutoCloseDropdownMenu() {
        if self.autoCloseEnabled {
            guard let rootView = CurrentWindow.rootView else { return }
            rootView.makeTapGesture { make in
                make
                    .setStateGesture([.ended])
                    .setAction (closure: verifyTappedOutMenu)
            }
        }
    }
    
    private func verifyTappedOutMenu(_ tap: TapGesture) {
        print("CLICOUUUUUUUUUUUUUUU NO OVERLAYYYYYYYYYYYYYYYYYYYYY PORRAAAAAA")
        if self._isShow {
            if self.isTappedOut(tap) {
                self.isShow = false
            }
        }
    }
    
    private func isTappedOut(_ tap: TapGesture) -> Bool {
        let touchPoint = tap.getTouchedPositionRelative(to: .window)
        if isTappedOutDropdownMenu(touchPoint) && isTappedOutExcludeComponents(touchPoint) {
            return true
        }
        return false
    }
    
    private func isTappedOutDropdownMenu(_ touchPoint: CGPoint) -> Bool {
        if self.frame.contains(touchPoint) {
            return false
        }
        return true
    }
    
    private func isTappedOutExcludeComponents(_ touchPoint: CGPoint) -> Bool {
        var isTappedOut = true
        self.excludeComponents.forEach { comp in
            if comp.frame.contains(touchPoint) {
                isTappedOut = false
                return
            }
        }
        return isTappedOut
    }
    

    private func isPresented() {
        list.isShow = self._isShow
        self.isHidden = !self._isShow
//        self.overlay?.isShow = self._isShow
    }
    
  
    private func bringToFront() {
        if !_isShow { return }
        guard let rootView = CurrentWindow.rootView else { return }
        rootView.bringSubviewToFront(self)
    }
    
    
    
    private func addListOnDropdownMenu() {
        list.add(insideTo: self)
    }
    
    private func configDropDownMenuConstraints() {
        guard let padding = self.paddingMenu else {return}
        self.list.makeConstraints { build in
            build.setTop.equalToSuperView(padding.top)
                .setBottom.equalToSuperView(-padding.bottom)
                .setLeading.equalToSuperView(padding.left)
                .setTrailing.equalToSuperView(-padding.right)
        }
    }
    
    
    
}
