//
//  DropdownMenu.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 01/05/23.
//

import UIKit


class DropdownMenu: View {
    
    typealias onTapDropdownMenuAlias = ((_ section: Int, _ row: Int) -> Void)
    
    enum PositionMenu {
        case leftTop
        case leftBottom
        case rightTop
        case rightBottom
    }
    
    
    private var onTapDropdownMenu: onTapDropdownMenuAlias?

    
    private var zPosition: CGFloat = 10001
    private var positionOpenMenu: DropdownMenu.PositionMenu = .rightBottom
    private var menuHeight: CGFloat?
    private var menuWidth: CGFloat?
    private var paddingMenu: UIEdgeInsets?
    private var paddingCells: UIEdgeInsets?
    private var openingPoint: CGPoint?
    
    
    override init() {
        super.init(frame: .zero)
        self.initialization()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var list: List = {
        let list = List(.grouped)
            .setShowsVerticalScrollIndicator(false)
            .setSeparatorStyle(.none)
            .setSectionHeaderHeight(30)
            .setSectionFooterHeight(20)
            .setDidSelectRow({ section, row in
                print(section, row)
            })
            .setBackgroundColor(.clear)
        return list
    }()
    
    
    private func initialization() {
        self.hide()
        setTopMostPosition()
    }

    
    
//  MARK: - Set Properties
    
    func setPositionOpenMenu(_ position: DropdownMenu.PositionMenu) -> Self {
        self.positionOpenMenu = position
        return self
    }
    
    func setRowHeight(_ height: CGFloat) -> Self {
        _ = list.setRowHeight(height)
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
    
    func setPaddingMenu(top: CGFloat , left: CGFloat, bottom: CGFloat, right: CGFloat) -> Self {
        self.paddingMenu = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
        return self
    }
    
    func setPaddingColuns(left: CGFloat, right: CGFloat) -> Self {
        self.paddingCells = UIEdgeInsets(top: 0, left: left, bottom: 0, right: right)
        return self
    }
    
    
//  MARK: - SET Data In List
    
    func setSectionInDropdown(_ section: Section) {
        list.setSectionInList(section)
    }
    
    func setRowInSection(_ section: Section, _ row: Row) {
        list.setRowInSection(section, row)
    }
    
    func setRowInSection(section: Section, leftView: UIView?, middleView: UIView, rightView: UIView?) {
        let row = Row(leftView: leftView, middleView: middleView, rightView: rightView)
        section.rows.append(row)
    }
    
    
    
//  MARK: - Actions
    func setAction(_ closure: @escaping onTapDropdownMenuAlias) -> Self {
        self.onTapDropdownMenu = closure
        return self
    }
    
    
//  MARK: - Show DropdownMenu
    
    func show() {
        addListOnDropdownMenu()
        configConstraints()
        list.show()
        self.isHidden = false
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
    
}



