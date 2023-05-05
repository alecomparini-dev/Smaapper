//
//  ListCell.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 04/05/23.
//

import UIKit

class ListCell: UITableViewCell {
    static let identifier: String = String(describing: ListCell.self)
    
    private var stackView: UIStackView?
    private var spacer = View()
    
    private var listCellModel: ListCellModel?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.initialization()
        
        self.setBorder { build in
            build.setColor(.red)
                .setWidth(0)
        }
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialization() {

    }
    
    public func setupCell(_ listCellModel: ListCellModel? = nil) {
        self.listCellModel = listCellModel
        configCell()
        configViews()
        configText()
        configStackView()
        addStackView()
        addElementsToStackView()
        configConstraints()
        
    }
    
    
//  MARK: - Private Functions Area
    
    private func configCell() {
        self.backgroundColor = .clear
        self.selectionStyle = .none
    }
    
    private func configViews() {
        configLeftView()
        configRightView()
    }
    
    private func configLeftView() {
        guard let leftView = listCellModel?.leftView else {return}
        
        if leftView is UIImageView {
            setContentModeToScaleAspectFit(leftView as! UIImageView)
        }
        configWidthAnchor(leftView, 50)
    }
    
    private func configRightView() {
        guard let rightView = listCellModel?.rightView else {return}
        if rightView is UIImageView {
            setContentModeToScaleAspectFit(rightView as! UIImageView)
        }
        configWidthAnchor(rightView, 50)
    }
    
    private func configWidthAnchor(_ view: UIView, _ constant: CGFloat) {
        
        view.widthAnchor.constraint(lessThanOrEqualToConstant: constant).isActive = true
    }
    
    private func setContentModeToScaleAspectFit(_ imageView: UIImageView) {
        imageView.contentMode = .scaleAspectFit
    }
    
    private func configStackView() {
        self.stackView = UIStackView()
        stackView?.axis = .horizontal
        stackView?.spacing = 1
        stackView?.alignment = .center
        stackView?.distribution = .fill
        stackView?.tag = 100
    }
    
    private func configText() {
        let text = listCellModel?.text ?? Label()
        spacer.addSubview(text)
        text.applyConstraints { build in
            build.setLeading.setTrailing.equalToSuperView
                .setVerticalAlignmentY.equalToSuperView
        }
        
        //TODO: - Acho que não será preciso -
        if listCellModel?.rightView == nil {
            text.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
            text.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        } else {
            text.setContentCompressionResistancePriority(.required, for: .horizontal)
            text.setContentHuggingPriority(.required, for: .horizontal)
        }
    }
    
    private func addStackView() {
        if let existingStackView = self.contentView.viewWithTag(100) as? UIStackView {
            existingStackView.removeFromSuperview()
            print("removeu")
        }
        
        self.contentView.addSubview(stackView ?? UIStackView())
    }
    
    private func addElementsToStackView() {
        addLeftViewToStackView()
        addTextToStackView()
        addRightViewToStackView()
    }
    
    private func addLeftViewToStackView() {
        if let leftView = self.listCellModel?.leftView {
            stackView?.addArrangedSubview(leftView)
        }
    }
    
    private func addTextToStackView() {
        stackView?.addArrangedSubview(spacer)
    }
    
    private func addRightViewToStackView() {
        if let rightView = self.listCellModel?.rightView {
            stackView?.addArrangedSubview(rightView)
        }
    }
    
    private func configConstraints() {
        stackView?.applyConstraints { build in
            build.setTop.setLeading.setBottom.setTrailing.equalToSuperView
        }
    }
    
}
