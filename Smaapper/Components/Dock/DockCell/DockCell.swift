//
//  DockCell.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 16/05/23.
//

import UIKit

class DockCell: UICollectionViewCell {
    
    static let identifier: String = String(describing: DockCell.self)
    private var isUserInteraction: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupCell(_ iconButton: IconButton) {
        removeSubViews(contentView)
        iconButton.add(insideTo: self.contentView)
        iconButton.makeConstraints { make in
            make.setPin.equalToSafeArea
        }
    }
    
    
    private func removeSubViews(_ view: UIView) {
        view.subviews.forEach { subView in
            subView.removeFromSuperview()
        }
    }
    
}
