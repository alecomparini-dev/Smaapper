//
//  List.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 04/05/23.
//

import UIKit

class List: UITableView {

    typealias completionRow = ((_ row: Int, _ section: Int?) -> Void)?
    
    private var rows: [ListCellModel] = []
    
    init() {
        super.init(frame: .zero, style: .plain)
        self.initialization()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialization() {
        self.RegisterCell()
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
    
    func setRow(isSection: Bool, leftView: UIView?, middleView: UIView, rightView: UIView?, completion: completionRow) -> Self {
        let cell = ListCellModel(isSection: isSection, leftView: leftView, middleView: middleView, rightView: rightView, completion:  completion)
        self.rows.append(cell)
        return self
    }
    
    func show() {
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
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return self.rows.filter({ $0.isSection == true }).count
//    }
    
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        switch section {
//        case 0:
//            return self.rows[0].middleView
//        case 1:
//            return self.rows[2].middleView
//        case 2:
//            return self.rows[6].middleView
//        default:
//            return nil
//        }
//    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        switch section {
//        case 0:
//            return 1
//
//        case 1:
//            return 3
//
//        case 2:
//            return 2
//
//        default:
//            return 1
//        }
        
        return self.rows.count
        
    }
    
//    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
//        if section == 0, let headerView = view as? UITableViewHeaderFooterView {
//            headerView.contentView.backgroundColor = .red
//        }
//    }
//
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ListCell.identifier, for: indexPath) as! ListCell
        
//        let img = ImageView()
//            .setImage(UIImage(systemName: "person"))
//            .setContentMode(.center)
//            .setSize(18)
//            .setTintColor(.white)
//            .setBorder { build in
//                build.setColor(.yellow)
//                    .setWidth(0)
//            }
//            .setOnTap { imageView in
//                print("caralhoooo - \(indexPath.row + 1)")
//            }
            
        
//        let imgRight = ImageView()
//            .setImage(UIImage(systemName: "chevron.forward"))
//            .setContentMode(.center)
//            .setSize(12)
//            .setTintColor(.white)
//            .setOnTap { imageView in
//                print("eh pra direita caralhooo - \(indexPath.row + 1)")
//            }
        
        let left = rows[indexPath.row].leftView
        let mid = rows[indexPath.row].middleView
        let right = rows[indexPath.row].rightView
        let listCellModel = ListCellModel(isSection: rows[indexPath.row].isSection, leftView: left, middleView: mid, rightView: right) { row, section in
            print(row, section ?? "")
        }
        
        cell.setupCell(listCellModel)
        
        print("seção: \(indexPath.section) - row: \(indexPath.row)  ")
        
        return cell 
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("linha clicada: \(indexPath.row) da seção: \(indexPath.section) ")
    }

}
