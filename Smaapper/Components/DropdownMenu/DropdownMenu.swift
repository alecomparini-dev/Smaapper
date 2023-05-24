//
//  DropdownMenu.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 01/05/23.
//

import UIKit

protocol DropdownMenuDelegate: AnyObject {
    func touchMenu()
    func openMenu()
    func closeMenu()
}

class DropdownMenu: View {
    
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
    
    private var positionOpenMenu: DropdownMenu.PositionMenu = .rightBottom
    private var menuHeight: CGFloat?
    private var menuWidth: CGFloat?
    private var paddingCells: UIEdgeInsets?
    private var autoCloseEnabled: Bool = false
    private var excludeComponents: [UIView] = []
    private var _paddingMenu: UIEdgeInsets?
    
    
//    private var overlay: Overlay?
    
    private var alreadyApplied = false
    private var _isShow = false
    private var zPosition: CGFloat = 10000
    
    
    
    var actions: DropdownMenuActions
    
    override init() {
        self.actions = DropdownMenuActions()
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
}
    
    lazy var list: List = {
        let list = List(.grouped)
            .setShowsVerticalScrollIndicator(false)
            .setSeparatorStyle(.none)
            .setSectionHeaderHeight(30)
            .setSectionFooterHeight(20)
            .setDidSelectRow({ section, row in
                if let touchMenuClosure = self.actions.touchMenuClosure {
                    touchMenuClosure((section,row))
                }
            })
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
    var paddingMenu: UIEdgeInsets? { self._paddingMenu }
    
//  MARK: - SET Attributes
    
    @discardableResult
    func setPositionOpenMenu(_ position: DropdownMenu.PositionMenu) -> Self {
        self.positionOpenMenu = position
        return self
    }
    
    @discardableResult
    func setRowHeight(_ height: CGFloat) -> Self {
        list.setRowHeight(height)
        return self
    }
    
    @discardableResult
    func setDropdownMenuHeight(_ height: CGFloat) -> Self {
        self.menuHeight = height
        return self
    }
    
    @discardableResult
    func setWidth(_ width: CGFloat) -> Self {
        self.menuWidth = width
        return self
    }
    
    @discardableResult
    func setPaddingMenu(top: CGFloat , left: CGFloat, bottom: CGFloat, right: CGFloat) -> Self {
        self._paddingMenu = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
        return self
    }
    
    @discardableResult
    func setPaddingColuns(left: CGFloat, right: CGFloat) -> Self {
        self.paddingCells = UIEdgeInsets(top: 0, left: left, bottom: 0, right: right)
        return self
    }
    
    @discardableResult
    func setSectionHeaderHeight(_ height: CGFloat) -> Self {
        list.setSectionHeaderHeight(height)
        return self
    }
    
    @discardableResult
    func setSectionFooterHeight(_ height: CGFloat) -> Self {
        list.setSectionFooterHeight(height)
        return self
    }
    
    @discardableResult
    func setSectionHeaderHeight(forSection: Int, _ height: CGFloat) -> Self {
        list.setSectionHeaderHeight(forSection: forSection, height)
        return self
    }
    
    @discardableResult
    func setSectionFooterHeight(forSection: Int, _ height: CGFloat) -> Self {
        list.setSectionFooterHeight(forSection: forSection, height)
        return self
    }
    
    @discardableResult
    func setAutoCloseMenuWhenTappedOut(excludeComponents: [UIView]) -> Self {
        self.autoCloseEnabled = true
        self.excludeComponents = excludeComponents
        return self
    }
    
    
    
//  MARK: - SET Data In List
    
    func setSectionInDropdown(_ section: Section) {
        list.setSectionInList(section)
    }
    
    func setRowInSection(_ section: Section, _ row: Row) {
        list.setRowInSection(section, row)
    }
    
    func setRowInSection(section: Section, leftView: UIView?, middleView: UIView, rightView: UIView?) {
        let row = Row(leftView: leftView, middleView: middleView, rightView: rightView)
        section.rows.append(row)
    }
    
    
    
//  MARK: - Show DropdownMenu
    
    var isShow: Bool {
        get {
            return self._isShow }
        set {
            self._isShow = newValue
            applyOnceConfig()
            isPresented()
            bringToFront()
            callClosureOpenCloseMenu(self._isShow)
        }
    }
    
    
//  MARK: - Private Functions Area

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
    
    private func callClosureOpenCloseMenu(_ isShow: Bool) {
        callClosureOpenMenu()
        callClosureCloseMenu()
    }

    private func callClosureOpenMenu() {
        if let openMenuClosure = actions.openMenuClosure {
            if isShow {
                openMenuClosure(.open)
            }
        }
    }
    
    private func callClosureCloseMenu() {
        if let closeMenuClosure = actions.closeMenuClosure {
            if !isShow {
                closeMenuClosure(.close)
            }
        }
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



