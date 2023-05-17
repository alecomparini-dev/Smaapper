//
//  DockCell.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 16/05/23.
//

import UIKit

class DockCell: UICollectionViewCell {
    
    static let identifier: String = String(describing: DockCell.self)
    
    let iconImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .cyan
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(_ iconButton: IconButton) {
        contentView.addSubview(iconButton)
        iconButton.makeConstraints { make in
            make.setPin.equalToSuperView
        }
    }
    
}
