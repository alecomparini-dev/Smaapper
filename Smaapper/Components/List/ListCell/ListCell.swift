//
//  ListCell.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 04/05/23.
//

import UIKit

class ListCell: UITableViewCell {
    static let identifier: String = String(describing: ListCell.self)
    
    lazy var screenCell: ListCellView = {
        let screen = ListCellView()
            .setConstraints { build in
                build
                    .setPin.equalToSuperView
            }
        return screen
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.initialization()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialization() {
        addScreenCell()
        configCell()
    }
    
//  MARK: - SET Properties
    func setWidthLeftColumnCell(_ width: CGFloat) -> Self {
        _ = screenCell.setWidthLeftColumnCell(width)
        return self
    }
    
    func setWidthRightColumnCell(_ width: CGFloat) -> Self {
        _ = screenCell.setWidthRightColumnCell(width)
        return self
    }
    
    func setBackgroundColorCell(_ color: UIColor) -> Self {
        _ = screenCell.setBackgroundColorCell(color)
        return self
    }

    func setupCell(_ leftView: UIView?, _ middleView: UIView?, _ rightView: UIView?) {
        screenCell.setupCell(leftView, middleView, rightView)
    }
    
    
//  MARK: - Private Functions Area
    
    private func addScreenCell() {
        screenCell.add(insideTo: self.contentView)
        screenCell.applyConstraint()
    }
    
    private func configCell() {
        self.selectionStyle = .none
        self.backgroundColor = .clear
        
        
    }
    

}
