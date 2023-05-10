//
//  DropdownMenu.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 01/05/23.
//

import UIKit


class DropdownMenu: View {
    
    var seila = false
    
    
    typealias onTapDropdownMenuAlias = ((_ section: Int, _ row: Int) -> Void)
    enum PositionMenu {
        case leftTop
        case leftBottom
        case rightTop
        case rightBottom
    }
    
    private var result: [DropdownMenuSection] = []
    
    private var onTapDropdownMenu: onTapDropdownMenuAlias?
    private var layoutSubMenu: DropdownMenu?
    
    private var location: CGPoint?
    
    private var zPosition: CGFloat = 10001
    private var positionOpenMenu: DropdownMenu.PositionMenu = .rightBottom
    private var itemsHeight: CGFloat = 35
    private var menuHeight: CGFloat?
    private var menuWidth: CGFloat?
    private var paddingMenu: UIEdgeInsets?
    private var paddingCells: UIEdgeInsets?
    private var openingPoint: CGPoint?
    
    private var sections: [DropdownMenuSection] = []
    private let dropdownJson: [String: Any]?
    
    init(_ dropdownJson: [String: Any]? = nil) {
        self.dropdownJson = dropdownJson
        super.init()
        self.initialization()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var list: List = {
        let list = List(.grouped)
            .setShowsVerticalScrollIndicator(false)
            .setSeparatorStyle(.none)
            .setRowHeight(45)
            .setSectionHeaderHeight(30)
            .setSectionFooterHeight(20)
            .setDidSelectRow({ section, row in
                if let onTapDropdown = self.onTapDropdownMenu {
                    if let layoutSubMenu = self.layoutSubMenu {
                        if (layoutSubMenu.isHidden ) {
                            layoutSubMenu.show()
                        } else {
                            layoutSubMenu.hide()
                            return
                        }
                    }
                    onTapDropdown(section, row)
                }
            })
            .setBackgroundColor(.clear)
            .setBorder { build in
                build.setColor(.red)
                    .setWidth(0)
                    .setCornerRadius(20)
            }
            .setTapGesture { build in
                build
                    .setAction(closure: { tapGesture in
                        let position = tapGesture.getTouchedPositionRelative(to: .superview)
                        let dropFrame = self.bounds
                        let comp = tapGesture.getTouchedComponent()
                        let delta = dropFrame.origin.y - position.y
                        print(dropFrame.origin.y)
                        print(position.y)
//
//                        if let layoutSubMenu = self.layoutSubMenu {
//                            for constraint in layoutSubMenu.constraints {
//                                if constraint.firstAttribute == .bottom {
//                                    constraint.constant = -position.y
//                                    self.seila = true
//                                }
//                            }
//                        }
                        
                        if !self.seila {
                            self.layoutSubMenu?.makeConstraints({ make in
                                make.setTop.equalToSafeArea(20)
                                    .setBottom.equalToSafeArea(-200)
                                    .setLeading.equalToSafeArea(20)
                                    .setWidth.equalToConstant(275)
    //                                .setHeight.equalToConstant(500)
                            })
                        }
                        
                        self.layoutSubMenu?.createdRowList(self.result[0].items?[0].subMenu ?? [])

                    })
            }
        return list
    }()
    
    
    private func initialization() {
        self.hide()
        setTopMostPosition()
        addListOnDropdownMenu()
    }

    
    
//  MARK: - Set Properties
    
    func setPositionOpenMenu(_ position: DropdownMenu.PositionMenu) -> Self {
        self.positionOpenMenu = position
        return self
    }
    
    func setItemsHeight(_ height: CGFloat) -> Self {
        self.itemsHeight = height
        return self
    }
    
    func setHeight(_ height: CGFloat) -> Self {
        self.menuHeight = height
        return self
    }
    
    func setWidth(_ width: CGFloat) -> Self {
        self.menuWidth = width
        return self
    }
    
    func setSections(_ menuSection: DropdownMenuSection) -> Self {
        self.sections.append(menuSection)
        return self
    }
    
    func setPaddingMenu(top: CGFloat , left: CGFloat, bottom: CGFloat, right: CGFloat) -> Self {
        self.paddingMenu = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
        return self
    }
    
    func setPaddingColuns(left: CGFloat, right: CGFloat) -> Self {
        self.paddingCells = UIEdgeInsets(top: 0, left: left, bottom: 0, right: right)
        return self
    }
    
    func setOnTapDropdownMenu(_ closure: @escaping onTapDropdownMenuAlias) -> Self {
        self.onTapDropdownMenu = closure
        return self
    }
    
    func setDropdownMenuFromJson(_ json: Data) {
        dropdownMenuFromJson(json)
    }
    
    func setLayoutSubMenu(_ layoutSubMenu: DropdownMenu) {
        self.layoutSubMenu = layoutSubMenu
        DispatchQueue.main.async {
            self.layoutSubMenu?.add(insideTo: self.superview! )
        }
    }
    
    
//  MARK: - Show DropdownMenu
    
    func show() {
        configConstraints()
        list.show()
        self.isHidden = false
//
//        DispatchQueue.main.async {
//            self.layoutSubMenu?.makeConstraints({ make in
//                make.setTop.setLeading.setTrailing.equalToSuperView(10)
//                    .setHeight.equalToConstant(100)
//            })
//        }
        
    }

    func hide() {   
        self.isHidden = true
    }
    
//  MARK: - Private Functions Area
    
    private func setTopMostPosition() {
        self.layer.zPosition = zPosition
    }
    
    private func addListOnDropdownMenu() {
        list.add(insideTo: self)
    }
    
    private func configConstraints() {
        guard let padding = self.paddingMenu else {return}
        self.list.makeConstraints { build in
            build.setTop.equalToSuperView(padding.top)
                .setBottom.equalToSuperView(-padding.bottom)
                .setLeading.equalToSuperView(padding.left)
                .setTrailing.equalToSuperView(-padding.right)
        }
    }
    
    private func dropdownMenuFromJson(_ json: Data) {
        do {
            self.result = try JSONDecoder().decode(Dropdown.self, from: json)
            createdRowList(self.result)
        } catch {
            print(error)
        }
    }
    
    
    private func createdRowList(_ menu: [DropdownMenuSection]) {
        menu.forEach { sectionMenu in
            let section = Section(leftView: nil,
                                  middleView: createMiddleSectionView(sectionMenu))
            
            _ = list.setSection(section)
            
            sectionMenu.items?.enumerated().forEach({ (index, row) in
                let leftRowView = createLeftRowView(row, index)
                let middleRowView = createMiddleRowView(row, index)
                let rightRowView = createRightRowView(row, index)
                _ = section
                    .setRow(leftView: leftRowView, middleView: middleRowView, rightView: rightRowView)
            })
            
        }
        
    }
    
    private func createMiddleRowView(_ row: DropdownMenuItem, _ index: Int) -> UIView {
        let label = Label(row.title ?? "")
            .setColor(.white)
            .setFont(UIFont.systemFont(ofSize: 17, weight: .regular))
            .setTextAlignment(.left)
        
        return label
    }
    
    private func createLeftRowView(_ row: DropdownMenuItem, _ index: Int) -> UIView? {
        guard let leftImage = row.leftImage else {return nil}

        let img = ImageView()
            .setImage(UIImage(systemName: leftImage))
            .setContentMode(.center)
            .setSize(20)
            .setTintColor(.white)
            .setBorder { build in
                build.setColor(.yellow)
                    .setWidth(0)
            }
        return img
    }
    
    private func createRightRowView(_ row: DropdownMenuItem, _ index: Int) -> UIView? {
        guard let subMenu = row.subMenu else {return nil}
        if !subMenu.isEmpty {
            let img = ImageView()
                .setImage(UIImage(systemName: "chevron.forward"))
                .setContentMode(.center)
                .setSize(16)
                .setTintColor(.white)
            return img
        }
        return nil
    }
    
    private func createMiddleSectionView(_ section: DropdownMenuSection) -> UIView? {
        if section.section == nil { return nil}
        
        let label = Label(section.section ?? "")
            .setColor(UIColor.systemGray)
            .setFont(UIFont.systemFont(ofSize: 16, weight: .semibold))
            .setTextAlignment(.left)
        
        return label
    }
    
    
}



