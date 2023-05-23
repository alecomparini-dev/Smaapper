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
    
    private var alreadyApplied = false
    private var _isShow = false
    
    private var zPosition: CGFloat = 10000
    private var positionOpenMenu: DropdownMenu.PositionMenu = .rightBottom
    private var menuHeight: CGFloat?
    private var menuWidth: CGFloat?
    private var paddingCells: UIEdgeInsets?
    private var autoCloseEnabled: Bool = false
    private var excludeComponents: [UIView] = []
    
    var paddingMenu: UIEdgeInsets?
    
    var actions: DropdownMenuAction
    
    override init() {
        self.actions = DropdownMenuAction()
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
    
    
//  MARK: - Set Properties
    
    @discardableResult
    func setPositionOpenMenu(_ position: DropdownMenu.PositionMenu) -> Self {
        self.positionOpenMenu = position
        return self
    }
    
    @discardableResult
    func setRowHeight(_ height: CGFloat) -> Self {
        _ = list.setRowHeight(height)
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
        self.paddingMenu = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
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
        _ = list.setSectionFooterHeight(height)
        return self
    }
    
    @discardableResult
    func setSectionHeaderHeight(forSection: Int, _ height: CGFloat) -> Self {
        _ = list.setSectionHeaderHeight(forSection: forSection, height)
        return self
    }
    
    @discardableResult
    func setSectionFooterHeight(forSection: Int, _ height: CGFloat) -> Self {
        _ = list.setSectionFooterHeight(forSection: forSection, height)
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
            bringToFront()
            isPresented()
            callClosureOpenCloseMenu(self._isShow)
        }
    }
    
    
//  MARK: - Private Functions Area

    private func applyOnceConfig() {
        if self._isShow && !alreadyApplied {
            self.setTopMostPosition()
            self.addListOnDropdownMenu()
            self.configConstraints()
            self.configAutoCloseMenu()
            self.alreadyApplied = true
        }
    }

    private func configAutoCloseMenu() {
        if self.autoCloseEnabled {
            if let superview = self.superview {
                superview.makeTapGesture { make in
                    make
                        .setStateGesture([.ended])
                        .setAction (closure: verifyTappedOutMenu)
                }
            }
        }
    }
    
    private func verifyTappedOutMenu(_ tap: TapGesture) {
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
        if let superview = self.superview {
            superview.bringSubviewToFront(self)
        }
    }
    
    private func setTopMostPosition() {
        self.layer.zPosition = zPosition
    }
    
    private func addListOnDropdownMenu() {
        list.add(insideTo: self)
    }
    
    private func configConstraints() {
        guard let padding = self.paddingMenu else {return}
        self.list.makeConstraints { build in
            build.setTop.equalToSuperView(padding.top)
                .setBottom.equalToSuperView(-padding.bottom)
                .setLeading.equalToSuperView(padding.left)
                .setTrailing.equalToSuperView(-padding.right)
        }
    }
    
}



