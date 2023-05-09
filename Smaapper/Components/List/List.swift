//
//  List.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 04/05/23.
//

import UIKit


class List: UITableView {

    typealias onTapRow = ((_ section: Int, _ row: Int) -> Void)

    private var onTapRow: onTapRow?
    private var sections = [Section]()
    
    init(_ style: UITableView.Style) {
        super.init(frame: .zero, style: style)
        self.initialization()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialization() {
        self.setDefaultValues()
    }
    
    
//  MARK: - SET Properties
    
    func setRowHeight(_ height: CGFloat) -> Self {
        self.rowHeight = height
        return self
    }
    
    func setSectionHeaderHeight(_ height: CGFloat) -> Self {
        self.sectionHeaderHeight = height
        return self
    }
    
    func setSectionFooterHeight(_ height: CGFloat) -> Self {
        self.sectionFooterHeight = height
        return self
    }
    
    func setSeparatorStyle(_ style: UITableViewCell.SeparatorStyle) -> Self {
        self.separatorStyle = style
        return self
    }
    
    func setShowsVerticalScrollIndicator(_ flag: Bool) -> Self {
        self.showsVerticalScrollIndicator = flag
        return self
    }
    
    func setIsScrollEnabled(_ flag: Bool) -> Self {
        self.isScrollEnabled = flag
        return self
    }
    
    func setPadding(top: CGFloat , left: CGFloat, bottom: CGFloat, right: CGFloat) -> Self {
        self.contentInset = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
        return self
    }
    
    func setSection(_ section: Section) -> Self {
        self.sections.append(section)
        return self
    }
    
    func setOnTapRow(_ closure: @escaping onTapRow) -> Self {
        self.onTapRow = closure
        return self
    }
    
    
//  MARK: - Show List
    
    func show() {
        self.RegisterCell()
        delegate = self
        dataSource = self
    }

    
//  MARK: - Private Function Area
    
    private func setDefaultValues() {
        _ = setRowHeight(ListDefault.rowHeight)
    }
    
    private func RegisterCell() {
        self.register(ListCell.self, forCellReuseIdentifier: ListCell.identifier)
    }
    

}

//  MARK: - Extension Delegate

extension List: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return calculateHeightForHeaderInSection(section)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return calculateHeihtForFooterInSection(section)
    }
    
    private func calculateHeihtForFooterInSection(_ section: Int) -> CGFloat {
        if isSectionEmpty(sections[section]) {
            return 0
        }
        return self.sectionFooterHeight
    }
    
    private func calculateHeightForHeaderInSection(_ section: Int) -> CGFloat {
        if isSectionEmpty(sections[section]) {
            return 1
        }
        return self.sectionHeaderHeight
    }
    
    private func isSectionEmpty(_ section: Section) -> Bool {
        if section.leftView == nil &&
            section.middleView == nil &&
            section.rightView == nil {
            return true
        }
        return false
    }
}

//  MARK: - Extension Data Source

extension List: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sections[section].rows.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = ListCell()
        cell.setupCell(self.sections[section].leftView,
                       self.sections[section].middleView,
                       self.sections[section].rightView)
        return cell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListCell.identifier, for: indexPath) as! ListCell
        cell.setupCell(
            self.sections[indexPath.section].rows[indexPath.row].leftView,
            self.sections[indexPath.section].rows[indexPath.row].middleView,
            self.sections[indexPath.section].rows[indexPath.row].rightView
        )
        return cell 
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let onTapRow = self.onTapRow {
            onTapRow(indexPath.section, indexPath.row)
        }
    }
    
}
