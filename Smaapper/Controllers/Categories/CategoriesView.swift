//
//  CategoriesView.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 13/05/23.
//

import UIKit


protocol CategoriesViewDelegate: AnyObject {
    func closeModalTapped()
    func didSelectRow(_ section: Int, _ row: Int)
}

class CategoriesView: UIView {
    
    weak var delegate: CategoriesViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialization()
    }

    private func initialization() {
        addElements()
        applyConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var viewGradient: ViewBuilder = {
        let view = ViewBuilder()
            .setGradient({ build in
                build
                    .setGradientColors(Theme.shared.currentTheme.backgroundColorGradient)
                    .setAxialGradient(.leftTopToRightBottom)
                    .apply()
            })
            .setConstraints { build in
                build.setPin.equalToSuperView
            }
        return view
    }()
    
    
    lazy var closeModalCategories: IconButtonBuilder = {
        let img = ImageViewBuilder(UIImage(systemName: "chevron.down"))
        let btn = IconButtonBuilder(img.view)
            .setImageColor(Theme.shared.currentTheme.onSurface)
            .setImageWeight(.semibold)
            .setConstraints { build in
                build
                    .setTop.equalToSafeArea(10)
                    .setLeading.equalToSafeArea(15)
                    .setWidth.equalToConstant(30)
            }
            .setActions { build in
                build
                    .setTarget(self, #selector(closeModalTapped), .touchUpInside)
            }
        return btn
    }()
    @objc
    private func closeModalTapped() {
        delegate?.closeModalTapped()
    }
    
    
    lazy var titleLabel: LabelBuilder = {
       var label = LabelBuilder()
            .setText("Categories")
            .setFont(UIFont.systemFont(ofSize: 22, weight: .thin))
            .setColor(Theme.shared.currentTheme.onSurface)
            .setTextAlignment(.left)
            .setConstraints { build in
                build
                    .setVerticalAlignmentY.equalTo(closeModalCategories.view,-3)
                    .setLeading.equalTo(closeModalCategories.view, .trailing,5)
            }
        return label
    }()
    
    
    lazy var underLineTitle: ViewBuilder = {
       var view = ViewBuilder()
            .setGradient({ build in
                build
                    .setGradientColors(Theme.shared.currentTheme.primaryGradient)
                    .setAxialGradient(.leftToRight)
                    .apply()
            })
            .setBorder({ build in
                build.setCornerRadius(2)
            })
            .setShadow({ build in
                build
                    .setOffset(width: 3, height: 3)
                    .setColor(.black.withAlphaComponent(0.8))
                    .setOpacity(1)
                    .setRadius(3)
                    .apply()
            })
            .setConstraints { build in
                build
                    .setTop.equalTo(titleLabel.view, .bottom, 3)
                    .setLeading.equalTo(titleLabel.view, .leading, 1)
                    .setHeight.equalToConstant(2)
                    .setWidth.equalToConstant(80)
            }
        return view
    }()
    
    
    lazy var searchTextField: TextFieldImageBuilder = {
        let img = ImageViewBuilder(UIImage(systemName: "magnifyingglass"))
            .setTintColor(Theme.shared.currentTheme.onSurfaceVariant)
        
        let tf = TextFieldImageBuilder(image: img.view, position: .right, margin: 25)
            .setPlaceHolder("Search")
            .setPlaceHolderColor(Theme.shared.currentTheme.onSurfaceVariant)
            .setPlaceHolderSize(15)
            .setFont(UIFont.systemFont(ofSize: 15))
            .setPadding(15, .left)
            .setTextColor(Theme.shared.currentTheme.onSurface)
            .setTintColor(Theme.shared.currentTheme.onSurface)
            .setBorder({ build in
                build
                    .setCornerRadius(8)
            })
            .setConstraints { build in
                build.setTop.equalTo(titleLabel.view, .bottom, 25)
                    .setLeading.setTrailing.equalToSafeArea(40)
                    .setHeight.equalToConstant(40)
            }
            .setNeumorphism({ build in
                build.setReferenceColor(Theme.shared.currentTheme.surfaceContainer)
                    .setShape(.concave)
                    .setLightPosition(.leftTop)
                    .setIntensity(to: .light, percent: 100)
                    .setBlur(to: .light, percent: 3)
                    .setBlur(to: .dark , percent: 5)
                    .setDistance(to: .light, percent: 3)
                    .setDistance(to: .dark, percent: 5)
                    .apply()
            })
        return tf
    }()
        
    
    lazy var list: ListBuilder = {
        let list = ListBuilder(.grouped)
            .setBackgroundColor(.clear)
            .setBorder({ build in
                build
                    .setCornerRadius(12)
                    .setWidth(0)
            })
            .setShowsVerticalScrollIndicator(false)
            .setRowHeight(50)
            .setSeparatorStyle(.none)
            .setWidthLeftColumnCell(50)
            .setWidthRightColumnCell(45)
            .setSectionHeaderHeight(45)
            .setSectionFooterHeight(20)
            .setConstraints { build in
                build
                    .setTop.equalTo(searchTextField.view, .bottom, 20)
                    .setLeading.setBottom.setTrailing.equalToSafeArea(20)
            }
            .setActions { build in
                build
                    .setDidSelectRow { [weak self] section, row in
                        self?.delegate?.didSelectRow(section, row)
                    }
            }

        return list
    }()
    
    
//  MARK: - Create Section Menu
    func createMiddleSectionView(_ text: String) -> UIView {
        let label = LabelBuilder("  \(text)")
            .setColor(Theme.shared.currentTheme.onSurface)
            .setFont(UIFont.systemFont(ofSize: 17, weight: .regular))
            .setTextAlignment(.left)
            .view
        return label
    }
    
    
//  MARK: - Create Rows Menu
    func createLeftRowView(_ systemNameImage: String) -> UIView {
        let view = ViewBuilder()
            .setBackgroundColor(Theme.shared.currentTheme.surfaceContainerHighest)
        
        let img = ImageViewBuilder()
            .setImage(UIImage(systemName: systemNameImage))
            .setContentMode(.center)
            .setSize(20)
            .setTintColor(Theme.shared.currentTheme.onSurface)
            .setConstraints({ build in
                build
                    .setPin.equalToSuperView
            })
        
        img.add(insideTo: view.view)
        img.applyConstraint()
        
        return view.view
    }
    
    func createMiddleRowView(_ text: String) -> UIView {
        let label = LabelBuilder("  \(text)")
            .setColor(Theme.shared.currentTheme.onSurface)
            .setFont(UIFont.systemFont(ofSize: 14, weight: .regular))
            .setTextAlignment(.left)
            .setBackgroundColor(Theme.shared.currentTheme.surfaceContainer)
            .view
        return label
    }

    func createRightRowView(_ systemNameImage: String, _ color: UIColor) -> UIView {
        let view = ViewBuilder()
            .setBackgroundColor(Theme.shared.currentTheme.surfaceContainer.withAlphaComponent(0.8))
            
        let img = ImageViewBuilder(UIImage(systemName: systemNameImage))
            .setContentMode(.center)
            .setSize(12)
            .setTintColor(color)
            .setWeight(.regular)
            .setConstraints({ build in
                build
                    .setPin.equalToSuperView
            })
            
        img.add(insideTo: view.view)
        img.applyConstraint()
        
        return view.view
    }

    func setCornerRadiusOnView(_ view: UIView, _ corner: [BorderBuilder.Corner]) {
        view.makeBorder { build in
            build
                .setCornerRadius(12)
                .setWhichCornersWillBeRounded(corner)
        }
    }
    
//  MARK: - Private Functions Area
    
    private func addElements() {
        viewGradient.add(insideTo: self)
        closeModalCategories.add(insideTo: self)
        titleLabel.add(insideTo: self)
        underLineTitle.add(insideTo: self)
        searchTextField.add(insideTo: self)
        list.add(insideTo: viewGradient.view)
    }
    
    private func applyConstraints() {
        viewGradient.applyConstraint()
        closeModalCategories.applyConstraint()
        titleLabel.applyConstraint()
        underLineTitle.applyConstraint()
        searchTextField.applyConstraint()
        list.applyConstraint()
    }
    

    
}
