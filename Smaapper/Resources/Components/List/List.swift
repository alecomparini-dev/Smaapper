//
//  List.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 04/05/23.
//

import UIKit

protocol ListActionsDelegate: AnyObject {
    func didSelectRow(_ section: Int, _ row: Int)
}


class List: UITableView {

    weak var listDelegate: ListActionsDelegate?

    private var _customSectionHeaderHeight: [Int : CGFloat] = [:]
    private var _customSectionFooterHeight: [Int : CGFloat] = [:]
    private var _customRowHeight: [Int : [Int : CGFloat]] = [:]
    private var _widthLeftColumnCell: CGFloat = 35
    private var _widthRightColumnCell: CGFloat = 35
    private var _backgroundColorCell: UIColor = .clear
    
    private var _sections = [Section]()
    
    init(_ style: UITableView.Style) {
        super.init(frame: .zero, style: style)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
//  MARK: - GET Properties
    
    var customSectionHeaderHeight: [Int : CGFloat] {
        get { self._customSectionHeaderHeight }
        set { self._customSectionHeaderHeight = newValue }
    }
    
    var customSectionFooterHeight: [Int : CGFloat] {
        get { self._customSectionFooterHeight }
        set { self._customSectionFooterHeight = newValue }
    }
    
    var widthLeftColumnCell: CGFloat {
        get { self._widthLeftColumnCell }
        set { self._widthLeftColumnCell = newValue }
    }
    
    var widthRightColumnCell: CGFloat {
        get { self._widthRightColumnCell }
        set { self._widthRightColumnCell = newValue }
    }
    
    var backgroundColorCell: UIColor {
        get { self._backgroundColorCell }
        set { self._backgroundColorCell = newValue }
    }
    
    var sections: [Section] {
        get { self._sections }
        set { self._sections = newValue }
    }
    
    var customRowHeight: [Int : [Int : CGFloat]] {
        get { self._customRowHeight }
        set { self._customRowHeight = newValue }
    }
    
}


//  MARK: - Extension Delegate
extension List: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.customSectionHeaderHeight[section] ?? self.sectionHeaderHeight
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return self.customSectionFooterHeight[section] ?? self.sectionFooterHeight
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.customRowHeight[indexPath.section]?[indexPath.row] ?? self.rowHeight
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
        
        _ = cell
            .setWidthLeftColumnCell(self.widthLeftColumnCell)
            .setWidthRightColumnCell(self.widthRightColumnCell)
            .setBackgroundColorCell(self.backgroundColorCell)
        
        cell.setupCell(
            self.sections[indexPath.section].rows[indexPath.row].leftView,
            self.sections[indexPath.section].rows[indexPath.row].middleView,
            self.sections[indexPath.section].rows[indexPath.row].rightView
        )
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        listDelegate?.didSelectRow(indexPath.section, indexPath.row)
    }
    
    
}



