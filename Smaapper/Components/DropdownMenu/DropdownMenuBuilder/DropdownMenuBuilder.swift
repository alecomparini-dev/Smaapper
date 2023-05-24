//
//  DropdownMenuBuilder.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 24/05/23.
//

import UIKit


class DropdownMenuBuilder: BaseAttributeBuilder {
   
    private var dropdown: DropdownMenu_
    
    init() {
        self.dropdown = DropdownMenu_()
        super.init(self.dropdown)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var get: DropdownMenu_ { self.dropdown }
    
//  MARK: - SET Attributes
    
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

    
}
