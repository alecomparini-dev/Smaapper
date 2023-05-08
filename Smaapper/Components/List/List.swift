//
//  List.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 04/05/23.
//

import UIKit

//protocol ListComponent {
//    var leftView: UIView? {get set}
//    var middleView: UIView? {get set}
//    var rightView: UIView? {get set}
//}

class List: UITableView {

//    typealias completionRow = ((_ row: Int) -> Void)
    
    private var sections = [Section]()
    
    init() {
        super.init(frame: .zero, style: .plain)
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
    
    
    func show() {
        self.RegisterCell()
        delegate = self
        dataSource = self
        
//        self.rows.forEach { row in
//            print(row.middleView)
//        }
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
        return self.sections[section].leftView
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
//        rows[indexPath.row].completion(indexPath.row)
    }
    
}
