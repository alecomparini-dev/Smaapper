//
//  ListBuilder.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 25/05/23.
//

import UIKit


class ListBuilder: BaseBuilder {
    
    private var alreadyApplied = false
    private var _isShow = false
    private var list: List
    
    private var actions: ListActions?
    var view: List { self.list }
    
    init(_ style: UITableView.Style) {
        self.list = List(style)
        super.init(self.list)
    }
    
    
//  MARK: - SET Properties
    @discardableResult
    func setRowHeight(_ height: CGFloat) -> Self {
        list.rowHeight = height
        return self
    }
    
    @discardableResult
    func setCustomRowHeight(forSection: Int, forRow: Int, _ height: CGFloat) -> Self {
        list.customRowHeight.updateValue([forRow : height], forKey: forSection)
        return self
    }
    
    @discardableResult
    func setSectionHeaderHeight(_ height: CGFloat) -> Self {
        list.sectionHeaderHeight = height
        return self
    }
    
    @discardableResult
    func setSectionHeaderHeight(forSection: Int, _ height: CGFloat) -> Self {
        list.customSectionHeaderHeight.updateValue(height, forKey: forSection)
        return self
    }
    
    @discardableResult
    func setSectionFooterHeight(_ height: CGFloat) -> Self {
        list.sectionFooterHeight = height
        return self
    }
    
    @discardableResult
    func setSectionFooterHeight(forSection: Int, _ height: CGFloat) -> Self {
        list.customSectionFooterHeight.updateValue(height, forKey: forSection)
        return self
    }
    
    @discardableResult
    func setWidthLeftColumnCell(_ width: CGFloat) -> Self {
        list.widthLeftColumnCell = width
        return self
    }
    
    @discardableResult
    func setWidthRightColumnCell(_ width: CGFloat) -> Self {
        list.widthRightColumnCell = width
        return self
    }
    
    @discardableResult
    func setBackgroundColorCell(_ color: UIColor) -> Self {
        list.backgroundColorCell = color
        return self
    }
    
    @discardableResult
    func setSeparatorStyle(_ style: UITableViewCell.SeparatorStyle) -> Self {
        list.separatorStyle = style
        return self
    }
    
    @discardableResult
    func setShowsVerticalScrollIndicator(_ flag: Bool) -> Self {
        list.showsVerticalScrollIndicator = flag
        return self
    }
    
    @discardableResult
    func setIsScrollEnabled(_ flag: Bool) -> Self {
        list.isScrollEnabled = flag
        return self
    }
    
    
//  MARK: - SET Actions
    @discardableResult
    func setActions(_ action: (_ build: ListActions) -> ListActions) -> Self {
        self.actions = action(ListActions(self))
        return self
    }
    
    
//  MARK: - Populate List
    
    func setSectionInList(_ section: Section) {
        list.sections.append(section)
    }
    
    func setRowInSection(section: Section, leftView: UIView?, middleView: UIView, rightView: UIView?) {
        let row = Row(leftView: leftView, middleView: middleView, rightView: rightView)
        section.rows.append(row)
    }
    
    func setRowInSection(_ section: Section, _ row: Row) {
        section.rows.append(row)
    }
    
    
    
//  MARK: - Show List
    
    var isShow: Bool {
        get { return self._isShow }
        set {
            self._isShow = newValue
            applyOnceConfig()
            list.isHidden = !self._isShow
        }
    }
    
    
//  MARK: - Private Area
    private func applyOnceConfig() {
        if self._isShow && !alreadyApplied {
            registerCell()
            setDelegate()
            alreadyApplied = true
        }
    }
    
    private func registerCell() {
        list.register(ListCell.self, forCellReuseIdentifier: ListCell.identifier)
    }
    
    private func setDelegate() {
        list.delegate = list
        list.dataSource = list
    }
    
    
}




