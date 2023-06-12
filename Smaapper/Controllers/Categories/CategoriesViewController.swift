//
//  CategoriesViewController.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 13/05/23.
//

import UIKit

protocol CategoriesViewControllerDelegate: AnyObject {
    func selectedCategory(_ section: Int, _ row: Int)
}

class CategoriesViewController: UIViewController {

    weak var delegate: CategoriesViewControllerDelegate?
    
    private let categories: DropdownMenuData
    private var indexSection = 0
    private var indexRow = 0
    
    lazy var screen: CategoriesView = {
        let home = CategoriesView(frame: .zero)
        return home
    }()
    
    required init(_ categories: DropdownMenuData) {
        self.categories = categories
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = screen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateListCategories()
        configDelegate()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
//  MARK: - Private Function Area
    private func configDelegate() {
        screen.delegate = self
    }
    
    private func populateListCategories() {
        categories.enumerated().forEach { (index,sectionMenu) in
            self.indexSection = index
            let section = populateSection(sectionMenu.section)
            if let rows = sectionMenu.items {
                populateRowsOfSection(section, rows)
            }
        }
        screen.list.isShow = true
    }
    
    private func populateSection(_ sectionText: String? ) -> Section {
        let middleSectionView = screen.createMiddleSectionView(sectionText ?? "")
        let section = Section(leftView: nil, middleView: middleSectionView)
        screen.list.setSectionInList(section)
        return section
    }
    
    private func populateRowsOfSection(_ section: Section, _ rows: [RowDropdownMenuData] ) {
        rows.enumerated().forEach { (index,row) in
            self.indexRow = index
            let row: Row = self.createRowView(row)
            setCornerRadiusSection(row)
            screen.list.setRowInSection(section, row)
        }
    }
    
    private func createRowView(_ row: RowDropdownMenuData) -> Row {
        let leftView = createLeftView(row.leftImage)
        let middleView = createMiddleView(row.title)
        let rightView = createRightView(row)
        
        return Row(leftView: leftView, middleView: middleView, rightView: rightView)
    }
    
    private func createLeftView(_ leftImage: String?) -> UIView? {
        guard let leftImage else { return nil }
        let letfView = screen.createLeftRowView(leftImage)
        return letfView
    }
    
    private func createMiddleView(_ title: String?) -> UIView {
        guard let title else { return UIView() }
        return screen.createMiddleRowView(title)
    }
    
    private func createRightView(_ row: RowDropdownMenuData) -> UIView? {
        guard let rightImage = row.rightImage else { return nil }
        let rightView = screen.createRightRowView(rightImage, Theme.shared.currentTheme.onSurfaceVariant)
        return rightView
    }
    
    
    private func setCornerRadiusSection(_ row: Row) {
        setCornerRadiusFirstRowInSection(row)
        setCornerRadiusLastRowInSection(row)
    }
    
    private func setCornerRadiusFirstRowInSection(_ row: Row) {
        if indexRow == 0 {
            if let leftView = row.leftView,
               let rightView = row.rightView {
                screen.setCornerRadiusOnView(leftView, [.leftTop])
                screen.setCornerRadiusOnView(rightView, [.rightTop] )
            }
        }
    }
    
    private func setCornerRadiusLastRowInSection(_ row: Row) {
        guard let items = categories[self.indexSection].items else {return}
        
        if indexRow == items.count - 1 {
            if indexRow == 0 {
                if let leftView = row.leftView,
                   let rightView = row.rightView {
                    screen.setCornerRadiusOnView(leftView, [.leftTop, .leftBottom])
                    screen.setCornerRadiusOnView(rightView, [.rightTop, .rightBottom] )
                }
                return
            }
            if let leftView = row.leftView,
               let rightView = row.rightView {
                screen.setCornerRadiusOnView(leftView, [.leftBottom])
                screen.setCornerRadiusOnView(rightView, [.rightBottom] )
            }
        }
    }
    
}

//  MARK: - Extension CategoriesView Delegate
extension CategoriesViewController: CategoriesViewDelegate {
    
    func closeModalTapped() {
        dismiss(animated: true)
    }

    func didSelectRow(_ section: Int, _ row: Int) {
        dismiss(animated: true)
        delegate?.selectedCategory(section, row)
    }
    
}
