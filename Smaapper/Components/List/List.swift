//
//  List.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 04/05/23.
//

import UIKit

class List: UITableView {

    typealias completionRow = ((_ row: Int) -> Void)
    
    private var rows: [ListCellModel] = []
    
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
    
    func setRow(leftView: UIView?, middleView: UIView, rightView: UIView?, completion: @escaping completionRow) -> Self {
        let cell = ListCellModel(leftView: leftView, middleView: middleView, rightView: rightView, completion:  completion)
        self.rows.append(cell)
        return self
    }
    
    func show() {
        self.RegisterCell()
        delegate = self
        dataSource = self
        
        self.rows.forEach { row in
            print(row.middleView)
        }
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
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.rows.count
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ListCell.identifier, for: indexPath) as! ListCell
        
        cell.setupCell(rows[indexPath.row])
        
        return cell 
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        rows[indexPath.row].completion(indexPath.row)
    }
    
}
