//
//  DropdownMenuBuilder.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 24/05/23.
//

import UIKit


class DropdownMenuBuilder: BaseBuilder {
    
    private var alreadyApplied = false
    private var _isShow = false
    private var zPosition: CGFloat = 10000
    private var tapGestureBuilder: TapGestureBuilder?
    
    private(set) var dropdown: DropdownMenu
    var view: DropdownMenu { self.dropdown }
    
    private var actions: DropdownMenuActions?
    
    init() {
        self.dropdown = DropdownMenu()
        super.init(self.dropdown)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
//  MARK: - SET Properties
    
    @discardableResult
    func setPositionOpenMenu(_ position: DropdownMenu.PositionMenu) -> Self {
        self.dropdown.positionOpenMenu = position
        return self
    }
    
    @discardableResult
    func setRowHeight(_ height: CGFloat) -> Self {
        dropdown.list.setRowHeight(height)
        return self
    }
    
    @discardableResult
    func setDropdownMenuHeight(_ height: CGFloat) -> Self {
        dropdown.menuHeight = height
        return self
    }
    
    @discardableResult
    func setWidth(_ width: CGFloat) -> Self {
        dropdown.menuWidth = width
        return self
    }
    
    @discardableResult
    func setPaddingMenu(top: CGFloat , left: CGFloat, bottom: CGFloat, right: CGFloat) -> Self {
        dropdown.paddingMenu = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
        return self
    }
    
    @discardableResult
    func setPaddingColuns(left: CGFloat, right: CGFloat) -> Self {
        dropdown.paddingCells = UIEdgeInsets(top: 0, left: left, bottom: 0, right: right)
        return self
    }
    
    @discardableResult
    func setSectionHeaderHeight(_ height: CGFloat) -> Self {
        dropdown.list.setSectionHeaderHeight(height)
        return self
    }
    
    @discardableResult
    func setSectionFooterHeight(_ height: CGFloat) -> Self {
        dropdown.list.setSectionFooterHeight(height)
        return self
    }
    
    @discardableResult
    func setSectionHeaderHeight(forSection: Int, _ height: CGFloat) -> Self {
        dropdown.list.setSectionHeaderHeight(forSection: forSection, height)
        return self
    }
    
    @discardableResult
    func setSectionFooterHeight(forSection: Int, _ height: CGFloat) -> Self {
        dropdown.list.setSectionFooterHeight(forSection: forSection, height)
        return self
    }
    
    @discardableResult
    func setAutoCloseMenuWhenTappedOut(excludeComponents: [UIView]) -> Self {
        dropdown.autoCloseEnabled = true
        dropdown.excludeComponents = excludeComponents
        return self
    }
    
    
//  MARK: - SET Actions
    @discardableResult
    func setActions(_ action: (_ build: DropdownMenuActions) -> DropdownMenuActions) -> Self {
        self.actions = action(DropdownMenuActions())
        return self
    }
    
    
    //  MARK: - SET Data In List
    
    func setSectionInDropdown(_ section: Section) {
        dropdown.list.setSectionInList(section)
    }
    
    func setRowInSection(_ section: Section, _ row: Row) {
        dropdown.list.setRowInSection(section, row)
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
            callOnlyIsShow()
            presentation()
            callClosureOpenCloseMenu(self._isShow)
            bringToFront()
            isEnabledTapGesture(self._isShow)
        }
    }
    
    
    //  MARK: - PRIVATE AREA
    
    private func applyOnceConfig() {
        if !alreadyApplied {
            self.configList()
            self.configDropDownMenuConstraints()
            self.configAutoCloseDropdownMenu()
            self.configOverlay()
            self.setHierarchyVisualizationPosition()
            self.alreadyApplied = true
        }
    }
    
    private func callOnlyIsShow() {
        if self._isShow {
            applyOnceConfig()
            bringToFront()
        }
    }
    
    private func isEnabledTapGesture(_ enabled: Bool) {
        self.tapGestureBuilder?.setIsEnabled(enabled)
    }
    
    private func bringToFront() {
        guard let rootView = CurrentWindow.rootView else { return }
        rootView.bringSubviewToFront(dropdown)
    }
    
    private func configList() {
        self.addListOnDropdownMenu()
        self.addTouchActionOnList()
    }
    
    private func addTouchActionOnList() {
        dropdown.list.setActions({ build in
            build
                .setAction { section, row in
                    if let touchMenuClosure = self.actions?.touchMenuClosure {
                        touchMenuClosure((section,row))
                    }
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
        dropdown.overlay
            .setConstraints({ build in
                build
                    .setPin.equalTo(superview)
                    .apply()
            })
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
        dropdown.overlay.view.layer.zPosition = -1
    }
    
    private func configAutoCloseDropdownMenu() {
        if self.dropdown.autoCloseEnabled {
            guard let rootView = CurrentWindow.rootView else { return }
            self.tapGestureBuilder = TapGestureBuilder(rootView)
                .setTouchEnded({ [weak self] tapGesture in
                    guard let self else {return}
                    self.verifyTappedOutMenu(tapGesture)
                })
        }
    }
    
    private func verifyTappedOutMenu(_ tap: TapGesture) {
        if _isShow {
            if isTappedOut(tap) {
                isShow = false
            }
        }
    }
    
    private func isTappedOut(_ tap: TapGesture) -> Bool {
        let touchPoint = tap.getTouchPosition(.window)
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
    
    private func presentation() {
        dropdown.list.isShow = _isShow
        dropdown.isHidden = !_isShow
    }
    
    private func callClosureOpenCloseMenu(_ isShow: Bool) {
        callClosureOpenMenu()
        callClosureCloseMenu()
    }
    
    private func callClosureOpenMenu() {
        if let openMenuClosure = actions?.openMenuClosure {
            if isShow {
                openMenuClosure()
            }
        }
    }
    
    private func callClosureCloseMenu() {
        if let closeMenuClosure = actions?.closeMenuClosure {
            if !isShow {
                closeMenuClosure()
            }
        }
    }
    
    private func addListOnDropdownMenu() {
        dropdown.list.add(insideTo: dropdown)
    }
    
    private func configDropDownMenuConstraints() {
        guard let padding = dropdown.paddingMenu else {return}
        dropdown.list.setConstraints({ build in
            build
                .setTop.equalToSuperView(padding.top)
                .setBottom.equalToSuperView(-padding.bottom)
                .setLeading.equalToSuperView(padding.left)
                .setTrailing.equalToSuperView(-padding.right)
                .apply()
        })
    }
    
    
}
