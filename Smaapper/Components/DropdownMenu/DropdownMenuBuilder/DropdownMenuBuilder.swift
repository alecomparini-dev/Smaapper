//
//  DropdownMenuBuilder.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 24/05/23.
//

import UIKit


class DropdownMenuBuilder: BaseAttributeBuilder {
   
    private var alreadyApplied = false
    private var _isShow = false
    private var zPosition: CGFloat = 10000
    
    
    private var _dropdown: DropdownMenu_
    var dropdown: DropdownMenu_ { self._dropdown }
    
    init() {
        self._dropdown = DropdownMenu_()
        super.init(self._dropdown)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var view: DropdownMenu_ { self.dropdown }
    var actions: DropdownMenuActions = DropdownMenuActions()
    
    
//  MARK: - SET Attributes
    
    @discardableResult
    func setPositionOpenMenu(_ position: DropdownMenu.PositionMenu) -> Self {
        self._dropdown.positionOpenMenu = position
        return self
    }
    
    @discardableResult
    func setRowHeight(_ height: CGFloat) -> Self {
        _dropdown.list.setRowHeight(height)
        return self
    }
    
    @discardableResult
    func setDropdownMenuHeight(_ height: CGFloat) -> Self {
        _dropdown.menuHeight = height
        return self
    }
    
    @discardableResult
    func setWidth(_ width: CGFloat) -> Self {
        _dropdown.menuWidth = width
        return self
    }
    
    @discardableResult
    func setPaddingMenu(top: CGFloat , left: CGFloat, bottom: CGFloat, right: CGFloat) -> Self {
        _dropdown.paddingMenu = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
        return self
    }
    
    @discardableResult
    func setPaddingColuns(left: CGFloat, right: CGFloat) -> Self {
        _dropdown.paddingCells = UIEdgeInsets(top: 0, left: left, bottom: 0, right: right)
        return self
    }
    
    @discardableResult
    func setSectionHeaderHeight(_ height: CGFloat) -> Self {
        _dropdown.list.setSectionHeaderHeight(height)
        return self
    }
    
    @discardableResult
    func setSectionFooterHeight(_ height: CGFloat) -> Self {
        _dropdown.list.setSectionFooterHeight(height)
        return self
    }
    
    @discardableResult
    func setSectionHeaderHeight(forSection: Int, _ height: CGFloat) -> Self {
        _dropdown.list.setSectionHeaderHeight(forSection: forSection, height)
        return self
    }
    
    @discardableResult
    func setSectionFooterHeight(forSection: Int, _ height: CGFloat) -> Self {
        _dropdown.list.setSectionFooterHeight(forSection: forSection, height)
        return self
    }
    
    @discardableResult
    func setAutoCloseMenuWhenTappedOut(excludeComponents: [UIView]) -> Self {
        _dropdown.autoCloseEnabled = true
        _dropdown.excludeComponents = excludeComponents
        return self
    }
    
    
//  MARK: - SET Data In List
    
    func setSectionInDropdown(_ section: Section) {
        _dropdown.list.setSectionInList(section)
    }

    func setRowInSection(_ section: Section, _ row: Row) {
        _dropdown.list.setRowInSection(section, row)
    }

    func setRowInSection(section: Section, leftView: UIView?, middleView: UIView, rightView: UIView?) {
        let row = Row(leftView: leftView, middleView: middleView, rightView: rightView)
        section.rows.append(row)
    }

    
//  MARK: - SHOW DROPDOWN MENU
    
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
    
    
//  MARK: - PRIVATE AREA
    
    private func applyOnceConfig() {
        if self._isShow && !alreadyApplied {
            self.configList()
            self.configDropDownMenuConstraints()
            self.configAutoCloseDropdownMenu()
            self.configOverlay()
            self.setHierarchyVisualizationPosition()
            self.alreadyApplied = true
        }
    }

    private func configList() {
        self.addListOnDropdownMenu()
        self.addTouchActionOnList()
    }
    
    private func addTouchActionOnList() {
        dropdown.list.setDidSelectRow({ section, row in
            if let touchMenuClosure = self.actions.touchMenuClosure {
                touchMenuClosure((section,row))
            }
        })
    }
    
    private func configOverlay() {
        addOverlayInDropdownMenu()
        configOverlayConstraints()
        setOverlayHierarchyVisualizationPosition()
    }
    
    private func configOverlayConstraints() {
        guard let superview = self.dropdown.superview else {return}
        dropdown.overlay.makeConstraints { make in
            make
                .setPin.equalTo(superview)
        }
    }
    
    private func addOverlayInDropdownMenu() {
        dropdown.overlay.add(insideTo: dropdown)
    }
    
    private func setHierarchyVisualizationPosition() {
        setDropdownHierarchyVisualizationPosition()
        setExcludeComponentsHierarchyVisualizationPosition()
    }
    
    private func setDropdownHierarchyVisualizationPosition() {
        self.dropdown.layer.zPosition = zPosition
    }
    
    private func setExcludeComponentsHierarchyVisualizationPosition() {
        dropdown.excludeComponents.forEach { comp in
            comp.layer.zPosition = self.zPosition + 1
        }
    }
    
    private func setOverlayHierarchyVisualizationPosition() {
        dropdown.overlay.layer.zPosition = -1
    }
    
    private func configAutoCloseDropdownMenu() {
        if self.dropdown.autoCloseEnabled {
            guard let rootView = CurrentWindow.rootView else { return }
            rootView.makeTapGesture { make in
                make
                    .setStateGesture([.ended])
                    .setAction (closure: verifyTappedOutMenu)
            }
        }
    }
    
    private func verifyTappedOutMenu(_ tap: TapGesture) {
        print("TIRAR ISSOOOO")
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
        if self.dropdown.frame.contains(touchPoint) {
            return false
        }
        return true
    }
    
    private func isTappedOutExcludeComponents(_ touchPoint: CGPoint) -> Bool {
        var isTappedOut = true
        self.dropdown.excludeComponents.forEach { comp in
            if comp.frame.contains(touchPoint) {
                isTappedOut = false
                return
            }
        }
        return isTappedOut
    }
    
    private func isPresented() {
        dropdown.list.isShow = self._isShow
        self.dropdown.isHidden = !self._isShow
    }
    
    private func bringToFront() {
        if !_isShow { return }
        guard let rootView = CurrentWindow.rootView else { return }
        rootView.bringSubviewToFront(dropdown)
    }
    
    private func addListOnDropdownMenu() {
        dropdown.list.add(insideTo: dropdown)
    }
    
    private func configDropDownMenuConstraints() {
        guard let padding = self.dropdown.paddingMenu else {return}
        self.dropdown.list.makeConstraints { build in
            build.setTop.equalToSuperView(padding.top)
                .setBottom.equalToSuperView(-padding.bottom)
                .setLeading.equalToSuperView(padding.left)
                .setTrailing.equalToSuperView(-padding.right)
        }
    }

    
}
