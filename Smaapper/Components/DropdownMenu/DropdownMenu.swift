//
//  DropdownMenu.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 01/05/23.
//

import UIKit


class DropdownMenu: View {
    
    
    typealias onTapDropdownMenu = ((_ section: Int, _ row: Int) -> Void)
    enum PositionMenu {
        case leftTop
        case leftBottom
        case rightTop
        case rightBottom
    }
    
    private var onTap: onTapDropdownMenu?
    private var layoutSubMenu: DropdownMenu?
    
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
            .setOnTapRow({ section, row in
                if let onTap = self.onTap {
                    guard let layoutSubMenu = self.layoutSubMenu else {return }
                    if (layoutSubMenu.isHidden ) {
                        layoutSubMenu.show()
                    } else {
                        layoutSubMenu.hide()
                        return
                    }
                    onTap(section, row)
                }
            })
            .setBackgroundColor(.clear)
            .setBorder { build in
                build.setColor(.red)
                    .setWidth(0)
                    .setCornerRadius(20)
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
    
    func setOnTapDropdownMenu(_ closure: @escaping onTapDropdownMenu) -> Self {
        self.onTap = closure
        return self
    }
    
    func setDropdownMenuFromJson(_ json: Data) {
        dropdownMenuFromJson(json)
    }
    
    func setLayoutSubMenu(_ layoutSubMenu: DropdownMenu) {
        self.layoutSubMenu = layoutSubMenu
    }
    
    
//  MARK: - Show DropdownMenu
    
    func show() {
        configConstraints()
        list.show()
        self.isHidden = false
        
        
        print("------------- TUDO FINALIZADO ----------------")

        
        self.layoutSubMenu?.add(insideTo: self.superview ?? self)
        self.layoutSubMenu?.makeConstraints { make in
            make.setTop.setLeading.setTrailing.equalToSafeArea(60)
                .setHeight.equalToConstant(400)
        }
        
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
            let result = try JSONDecoder().decode(Dropdown.self, from: json)
            createdRowList(result)
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
            .setOnTap { img in
                print("caralhoooo - \(index)")
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
                .setOnTap { img in
                    print("SubMenu Porra ! - \(index)")
                }
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



