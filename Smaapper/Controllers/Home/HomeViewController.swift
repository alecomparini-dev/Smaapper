//
//  HomeVC.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 26/04/23.
//

import UIKit

class HomeVC: UIViewController {
    
    static let favorites = "Favorites"
    
    private let viewModel = HomeViewModel()
    
    private var dropdownMenu: DropdownMenuData?
    private var turnOnMenuButton = false
    private var openDropdownMenu = false
    private var indexSection = 0
    private var indexRow = 0
    
    lazy var homeScreen: HomeView = {
        let home = HomeView()
        return home
    }()
    
    override func loadView() {
        super.loadView()
        view = homeScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configDelegate()
        fetchDropdownMenu()
        
        //retirar !!!
        openCloseDropdownMenu()
        turnOnOffMenuButton()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    //  MARK: - Private Function Area
    
    private func configDelegate() {
        homeScreen.delegate = self
    }
    
    
    private func openCloseDropdownMenu() {
        if openDropdownMenu {
            homeScreen.dropdownMenu.hide()
        } else {
            homeScreen.dropdownMenu.show()
        }
        openDropdownMenu = !openDropdownMenu
    }
    
    private func turnOnOffMenuButton() {
        if turnOnMenuButton {
            homeScreen.turnOffMenuButton()
        } else {
            homeScreen.turnOnMenuButton()
        }
        turnOnMenuButton = !turnOnMenuButton
    }
    
    
    //  MARK: - Populate DropdowMenu
    
    private func fetchDropdownMenu() {
        viewModel.fetchDropdownMenu(.file) { result, error in
            if error != nil {
                print(error?.localizedDescription ?? "")
                return
            }
            if let result {
                self.dropdownMenu = result
                self.populateDropdownMenu()
            }
        }
    }
    
    private func populateDropdownMenu() {
        guard let dropdownMenu else {return }
        dropdownMenu.enumerated().forEach { (index,sectionMenu) in
            self.indexSection = index
            let section = populateSection(sectionMenu.section)
            if let rows = sectionMenu.items {
                populateRowsOfSection(section, rows)
            }
        }
    }
    
    private func populateSection(_ sectionText: String? ) -> Section {
        let middleSectionView = homeScreen.createMiddleSectionView(sectionText ?? "")
        let section = Section(leftView: nil, middleView: middleSectionView)
        homeScreen.dropdownMenu.setSectionInDropdown(section)
        return section
    }
    
    private func populateRowsOfSection(_ section: Section, _ rows: [RowDropdownMenuData] ) {
        rows.enumerated().forEach { (index,row) in
            self.indexRow = index
            let row: Row = self.createRowView(row)
            homeScreen.dropdownMenu.setRowInSection(section, row)
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
        return homeScreen.createLeftRowView(leftImage)
    }
    
    private func createMiddleView(_ title: String?) -> UIView {
        guard let title else { return UIView() }
        return homeScreen.createMiddleRowView(title)
    }
    
    private func createRightView(_ row: RowDropdownMenuData) -> UIView? {
        if let subMenu = row.subMenu {
            return addChevronToSubMenu(subMenu)
        }
        return addHeartToFavorites()
    }
    
    private func addChevronToSubMenu(_ subMenu: DropdownMenuData ) -> UIView? {
        if !subMenu.isEmpty {
            return homeScreen.createRightRowView("chevron.forward", .white.withAlphaComponent(0.4))
        }
        return nil
    }
    
    private func addHeartToFavorites() -> UIView? {
        guard let dropdownMenu else { return nil }
        if (dropdownMenu[self.indexSection].section == HomeVC.favorites) {
            return homeScreen.createRightRowView("heart.fill", .white.withAlphaComponent(0.8))
        }
        return nil
    }
    
}


//  MARK: - Extension HomeViewDelegate
extension HomeVC: HomeViewDelegate {
    func dropdownMenuTapped(_ section: Int, _ row: Int) {
        print("DELEGATE BOMBANDO CARALHO", section, row)
    }
    
    func menuButtonTapped() {
        openCloseDropdownMenu()
        turnOnOffMenuButton()
    }
    
}
