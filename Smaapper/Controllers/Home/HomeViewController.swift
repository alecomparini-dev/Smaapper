//
//  HomeVC.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 26/04/23.
//

import UIKit

class HomeVC: UIViewController {
    
    private let viewModel = HomeViewModel()
    
    private var turnOnMenuButton = false
    private var openDropdownMenu = false
    
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
                self.populateDropdownMenu(result)
            }
        }
    }
    
    private func populateDropdownMenu(_ dropdownMenu: DropdownMenuData) {
        dropdownMenu.forEach { sectionMenu in
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
        rows.forEach { row in
            let row: Row = self.createRowView(row)
            homeScreen.dropdownMenu.setRowInSection(section, row)
        }
    }
    
    private func createRowView(_ row: RowDropdownMenuData) -> Row {
        let leftView = createLeftView(row.leftImage)
        let middleView = createMiddleView(row.title)
        let rightView = createRightView(row.subMenu)
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
    
    private func createRightView(_ subMenu: DropdownMenuData?) -> UIView? {
        guard let subMenu else { return nil }
        if !subMenu.isEmpty {
            return homeScreen.createRightRowView("chevron.forward")
        }
        return nil
    }
    
}


//  MARK: - Extension HomeViewDelegate
extension HomeVC: HomeViewDelegate {
    func menuButtonTapped() {
        openCloseDropdownMenu()
        turnOnOffMenuButton()
    }
    
}
