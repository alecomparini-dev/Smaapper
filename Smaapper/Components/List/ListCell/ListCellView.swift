//
//  ListCellView.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 05/05/23.
//

import UIKit

class ListCellView: View {
    
    private let stackViewTag = 100
    
    override init() {
        super.init()
        addElements()
        configConstraints()
        
        _ = self.setBorder { build in
            build.setColor(.red)
                .setWidth(1)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    lazy var leftView: View = {
        let view = View()
            .setBackgroundColor(.cyan)
            .setConstraints { build in
                build.setTop.setBottom.equalToSuperView
                    .setLeading.equalToSuperView
                    .setWidth.equalToConstant(30)
            }
        return view
    }()
    
    lazy var middleView: View = {
        let view = View()
            .setBackgroundColor(.white)
            .setConstraints { build in
                build.setTop.setBottom.equalToSuperView
                    .setLeading.equalTo(leftView,.trailing, 2)
                    .setTrailing.equalTo(rightView,.leading, -2)
            }
            
        return view
    }()
    
    lazy var rightView: View = {
        let view = View()
            .setBorder({ build in
                build.setColor(.yellow)
                    .setWidth(1)
            })
            .setConstraints { build in
                build.setTop.setBottom.equalToSuperView
                    .setTrailing.equalToSuperView
                    .setWidth.equalToConstant(30)
            }
            .setBackgroundColor(.yellow)
            
        return view
    }()
    
    
    private func addElements() {
        leftView.add(insideTo: self)
        middleView.add(insideTo: self)
        rightView.add(insideTo: self)
    }
    
    private func configConstraints() {
        leftView.applyConstraint()
        middleView.applyConstraint()
        rightView.applyConstraint()
    }
    
    
    func setupCell(_ data: ListCellModel) {
//        addLeftViewToStackView(data.leftView)
//        addTextToStackView(data.text)
//        addRightViewToStackView(data.rightView)
    }
    
    
    private func addLeftViewToStackView(_ leftView: UIView?) {
        if let leftView {
//            stackView.addArrangedSubview(leftView)
            configWidthAnchor(leftView, 50)
        }
    }
    
    private func addRightViewToStackView(_ rightView: UIView?) {
        if let rightView {
//            stackView.addArrangedSubview(rightView)
            configWidthAnchor(rightView, 50)
        }
    }
    
    private func configWidthAnchor(_ view: UIView, _ constant: CGFloat) {
        view.widthAnchor.constraint(lessThanOrEqualToConstant: constant).isActive = true
    }
    
    private func addTextToStackView(_ text: Label) {
        text.makeConstraints { make in
            make.setTop.setWidth.setLeading.setBottom.equalToSuperView
        }
    }
    
    
    
    
    
}
