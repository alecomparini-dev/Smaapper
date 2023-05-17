//
//  CategoriesView.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 13/05/23.
//

import UIKit


protocol CategoriesViewDelegate: AnyObject {
    func closeModalTapped()
}

class CategoriesView: View {
    
    weak var delegate: CategoriesViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addElements()
        applyConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var viewGradient: View = {
        let view = View()
            .setGradient({ build in
                build
                    .setColor([UIColor.HEX("#17191a").getBrightness(1.7),  UIColor.HEX("#17191a").getBrightness(0.7)])
                    .setAxialGradient(.leftTopToRightBottom)
                    .apply()
            })
            .setConstraints { build in
                build.setPin.equalToSuperView
            }
        return view
    }()
    
    lazy var closeModalCategories: IconButton = {
        let img = ImageView(UIImage(systemName: "chevron.down"))
        let btn = IconButton(img)
            .setImageColor(.white.withAlphaComponent(0.3))
            .setImageWeight(.semibold)
            .setTarget(self, #selector(closeModalTapped), .touchUpInside)
            .setConstraints { build in
                build
                    .setTop.equalToSafeArea(10)
//                    .setHorizontalAlignmentX.equalToSafeArea
                    .setLeading.equalToSafeArea(15)
                    .setWidth.equalToConstant(30)
            }
        return btn
    }()
    @objc
    private func closeModalTapped() {
        delegate?.closeModalTapped()
    }
    
    
    lazy var titleLabel: Label = {
       var label = Label()
            .setText("Categories")
            .setFont(UIFont.systemFont(ofSize: 22, weight: .thin))
            .setColor(.white.withAlphaComponent(0.8))
            .setTextAlignment(.left)
            .setConstraints { build in
                build
                    .setVerticalAlignmentY.equalTo(closeModalCategories)
                    .setLeading.equalTo(closeModalCategories, .trailing,5)
            }
        return label
    }()
    
    
    lazy var underLineTitle: View = {
       var view = View()
            .setGradient({ build in
                build
                    .setColor([UIColor.HEX("#ff6b00"),UIColor.HEX("#f48537")])
                    .setAxialGradient(.rightToLeft)
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
                    .setBlur(3)
                    .apply()
            })
            .setConstraints { build in
                build
                    .setTop.equalTo(titleLabel, .bottom, 3)
                    .setLeading.equalTo(titleLabel, .leading, 1)
                    .setHeight.equalToConstant(2)
                    .setWidth.equalToConstant(80)
            }
        return view
    }()
    
    
    lazy var searchTextField: TextFieldImage = {
        let img = ImageView(UIImage(systemName: "magnifyingglass"))
            .setTintColor(.white.withAlphaComponent(0.3))
        
        let tf = TextFieldImage(image: img, position: .right, margin: 25)
            .setPlaceHolder("Search")
            .setPlaceHolderColor(.white.withAlphaComponent(0.4))
            .setPlaceHolderSize(15)
            .setFont(UIFont.systemFont(ofSize: 15))
            .setPadding(15, .left)
            .setTextColor(.white.withAlphaComponent(0.8))
            .setBorder({ build in
                build.setCornerRadius(8)
            })
            .setNeumorphism({ build in
                build.setReferenceColor(UIColor.HEX("#2b2f30"))
                    .setShape(.flat)
                    .setLightPosition(.leftTop)
                    .setIntensity(to: .light, percent: 0.7)
                    .setBlur(to: .light, percent: 3)
                    .setBlur(to: .dark , percent: 5)
                    .setDistance(to: .light, percent: 3)
                    .setDistance(to: .dark, percent: 5)
                    .apply()
            })
            .setConstraints { build in
                build.setTop.equalTo(titleLabel, .bottom, 25)
                    .setLeading.setTrailing.equalToSafeArea(40)
                    .setHeight.equalToConstant(40)
            }
        return tf
    }()
    
    lazy var list: List = {
        let list = List(.grouped)
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
                    .setTop.equalTo(searchTextField, .bottom, 20)
                    .setLeading.setBottom.setTrailing.equalToSafeArea(20)
            }
        return list
    }()
    
    
//  MARK: - Create Section Menu
    func createMiddleSectionView(_ text: String) -> UIView {
        let label = Label("  \(text)")
            .setColor(.white)
            .setFont(UIFont.systemFont(ofSize: 17, weight: .regular))
            .setTextAlignment(.left)
        return label
    }
    
    
//  MARK: - Create Rows Menu
    func createLeftRowView(_ systemNameImage: String) -> View {
        let view = View()
            .setBackgroundColor(UIColor.HEX("#2b2f30"))
        
        let img = ImageView()
            .setImage(UIImage(systemName: systemNameImage))
            .setContentMode(.center)
            .setSize(20)
            .setTintColor(.white.withAlphaComponent(0.9))
        
        img.add(insideTo: view)
        img.makeConstraints { make in
            make.setPin.equalToSuperView
        }
        
        return view
    }
    
    func createMiddleRowView(_ text: String) -> UIView {
        let label = Label("  \(text)")
            .setBackgroundColor(UIColor.HEX("#2b2f30").withAlphaComponent(0.3))
            .setColor(.white)
            .setFont(UIFont.systemFont(ofSize: 14, weight: .regular))
            .setTextAlignment(.left)
        return label
    }

    
    func createRightRowView(_ systemNameImage: String, _ color: UIColor) -> UIView {
        let view = View()
            .setBackgroundColor(UIColor.HEX("#2b2f30").withAlphaComponent(0.2))
            
        let img = ImageView()
            .setImage(UIImage(systemName: systemNameImage))
            .setContentMode(.center)
            .setSize(12)
            .setTintColor(color)
            .setWeight(.regular)
            
        img.add(insideTo: view)
        img.makeConstraints { make in
            make.setPin.equalToSuperView
        }
        
        return view
    }

    func setCornerRadiusOnView(_ view: UIView, _ corner: [Border.Corner]) {
        _ = view.makeBorder { build in
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
        list.add(insideTo: viewGradient)
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
