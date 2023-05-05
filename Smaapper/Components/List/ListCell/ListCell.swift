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
                build.setTop.setBottom.setLeading.setTrailing.equalToSuperView
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
    
    public func setupCell(_ listCellModel: ListCellModel) {
        screenCell.setupCell(listCellModel)
    }
    
    
//  MARK: - Private Functions Area
    private func addScreenCell() {
        self.contentView.addSubview(screenCell)
        screenCell.applyConstraint()
    }
    
    private func configCell() {
        self.selectionStyle = .none
        self.backgroundColor = .clear
    }
    
    
    private func setContentModeToScaleAspectFit(_ imageView: UIImageView) {
        imageView.contentMode = .scaleAspectFit
    }
    
    
//    private func configText() {
//        let text = listCellModel?.text ?? Label()
//        spacer.addSubview(text)
//        text.makeConstraints { build in
//            build.setLeading.setTrailing.equalToSuperView
//                .setVerticalAlignmentY.equalToSuperView
//        }
//
//        //TODO: - Acho que não será preciso -
//        if listCellModel?.rightView == nil {
//            text.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
//            text.setContentHuggingPriority(.defaultHigh, for: .horizontal)
//        } else {
//            text.setContentCompressionResistancePriority(.required, for: .horizontal)
//            text.setContentHuggingPriority(.required, for: .horizontal)
//        }
//    }
    
//    private func addStackView() {
//        if let existingStackView = self.contentView.viewWithTag(100) as? UIStackView {
//            existingStackView.removeFromSuperview()
//            print("removeu")
//        }
//
//        self.contentView.addSubview(stackView ?? UIStackView())
//    }
    
    

}
