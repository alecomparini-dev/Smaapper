//
//  HomeVC.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 26/04/23.
//

import UIKit

class HomeVC: UIViewController {
    
    static let favoritesID = "Favorites"
    static let categoriesID = "Categories"
    
    private let viewModel = HomeViewModel()
    
    private var adjustTrailingDock = NSLayoutConstraint()
    
    private var resultDropdownMenu: DropdownMenuData?
    private var turnOnMenuButton = false
    private var openDropdownMenu = false
    private var indexSection = 0
    private var indexRow = 0
    private var rowTapped: (section: Int, row: Int) = (0,0)
    
    lazy var homeScreen: HomeView = {
        let home = HomeView(frame: .zero)
        return home
    }()
    
    override func loadView() {
        super.loadView()
        view.addSubview(homeScreen)
        homeScreen.makeConstraints { make in
            make.setPin.equalToSuperView
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configDelegate()
        fetchDropdownMenu()
        configRowsHeightOfDropdowMenu()
        setConstraintAlignmentHorizontalDock()
        
        homeScreen.dropdownMenu.isShow = false
        
        //retirar !!!
        //        self.openCloseDropdownMenu()
        //        self.turnOnOffMenuButton()
        //        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
        //            self.dropdownMenuTapped((0,0))
        //        }
        
        
        homeScreen.applyStyle()

    }
    

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.async {
            self.homeScreen.dockIsShow(true)
            self.adjustAlignmentOfDock()
            self.addItemsDock()
            
            
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    //  MARK: - Private Function Area
    private func setConstraintAlignmentHorizontalDock() {
        self.adjustTrailingDock = homeScreen.dock.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        adjustTrailingDock.isActive = true
    }
    
    
    private func configDelegate() {
        homeScreen.delegate = self
    }
    
    
    private func openCloseDropdownMenu() {
        homeScreen.dropdownMenu.isShow = !homeScreen.dropdownMenu.isShow
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
                print(#function, #file, error?.localizedDescription ?? "")
                return
            }
            if let result {
                self.resultDropdownMenu = result
                self.populateDropdownMenu()
            }
        }
    }
    
    private func configRowsHeightOfDropdowMenu() {
        guard let resultDropdownMenu else {return }
        let lastSection = resultDropdownMenu.count - 1
        _ = homeScreen.dropdownMenu.setSectionFooterHeight(forSection: lastSection, 1)
    }
    
    private func populateDropdownMenu() {
        guard let resultDropdownMenu else {return }
        resultDropdownMenu.enumerated().forEach { (index,sectionMenu) in
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
        guard let rightImage = row.rightImage else { return nil }
        return homeScreen.createRightRowView(rightImage, .white)
    }
    
    private func addChevronToSubMenu(_ subMenu: DropdownMenuData ) -> UIView? {
        if !subMenu.isEmpty {
            return homeScreen.createRightRowView("chevron.forward", .white.withAlphaComponent(0.4))
        }
        return nil
    }
    
    private func addHeartToFavorites() -> UIView? {
        guard let resultDropdownMenu else { return nil }
        if (resultDropdownMenu[self.indexSection].section == HomeVC.favoritesID) {
            return homeScreen.createRightRowView("heart.fill", .white.withAlphaComponent(0.8))
        }
        return nil
    }
    
    private func showCategoriesViewController(_ subMenu: DropdownMenuData) {
        let categoriesVC = CategoriesViewController(subMenu)
        categoriesVC.modalPresentationStyle = .fullScreen
        present(categoriesVC, animated: true)
    }
    
    
    private func adjustAlignmentOfDock() {
    
        if homeScreen.getItemsDock().count == 4 {
            self.adjustTrailingDock.constant = -50
        }
        
        if homeScreen.getItemsDock().count > 4 {
            self.adjustTrailingDock.constant = -90
        }
        
    }
    
    
    private func addItemsDock() {
        
        let win1 = homeScreen.createIconsDock("trash")
        let win2 = homeScreen.createIconsDock("person")
        let win3 = homeScreen.createIconsDock("mic")
        let win4 = homeScreen.createIconsDock("person.circle")
        
        
        
        win1.applyNeumorphism()
        win4.applyNeumorphism()
        homeScreen.setItemsDock(win1)
        homeScreen.setItemsDock(win2)
        homeScreen.setItemsDock(win3)
        
        
        
        win4.add(insideTo: homeScreen)
        win4.makeConstraints { make in
            make.setPinTop.equalToSafeArea(100)
                .setHeight.equalToConstant(50)
        }
        
    }
    
    
}


//  MARK: - Extension HomeViewDelegate

extension HomeVC: HomeViewDelegate {
    func dropdownMenuTapped(_ rowTapped: (section: Int, row: Int)) {
        self.rowTapped = rowTapped
        openCategories()
    }
    
    func menuButtonTapped() {
        openCloseDropdownMenu()
        turnOnOffMenuButton()
    }
    
    private func openCategories() {
        guard let resultDropdownMenu else {return}
        guard let items = resultDropdownMenu[rowTapped.section].items else { return }
        if items[rowTapped.row].title == HomeVC.categoriesID {
            guard let subMenu = items[rowTapped.row].subMenu else { return }
            showCategoriesViewController(subMenu)
        }
        
    }
    
    
}
