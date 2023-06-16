//
//  HomeVC.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 26/04/23.
//

import UIKit

protocol HomeFloatViewControllerDelegate: AnyObject {
    func openFloatViewController(_ idApp: String, where: UIView)
}

class HomeViewController: UIViewController {
    
    var delegateFloatViewController: HomeFloatViewControllerDelegate?
    
    private let floatManager = FloatViewControllerManager.instance
    private var adjustTrailingDock = NSLayoutConstraint()
    
    static let favoritesID = "Favorites"
    static let categoriesID = "Categories"
    
    private var dockController = HomeViewDockController()
    private var indexCloseWin: Int?
    
    private let viewModel = HomeViewModel()
    private var categoriesVC: CategoriesViewController?
    private var resultDropdownMenu: DropdownMenuData?
    private var weather: WeatherFloatViewController?
    
    private var categories: DropdownMenuData = []
    
    private var indexSection = 0
    private var indexRow = 0
    private var rowTappedDropdownMenu: (section: Int, row: Int) = (0,0)
    private var rowTappedCategory: (section: Int, row: Int)?
    
    
    lazy var homeScreen: HomeView = {
        let home = HomeView(frame: .zero)
        return home
    }()
    
    override func loadView() {
        view = homeScreen.view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configDockController()
        configDropdownMenu()
        configDelegate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let rowTappedCategory {
            addFloatViewController(rowTappedCategory)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        rowTappedCategory = nil
    }
    
    
    //  MARK: - Private Function Area
    
    private func configDockController() {
        self.dockController = HomeViewDockController(homeScreen.dock)
        dockController.setConstraintAlignmentHorizontalDock(self.view)
        dockController.isShow = true
        dockController.verifyShowDock()
    }
    
    private func configDropdownMenu() {
        fetchDropdownMenu()
        configRowsHeightOfDropdowMenu()
        homeScreen.dropdownMenu.isShow = false
    }
    
    private func configDelegate() {
        homeScreen.setDelegate(self)
        floatManager.setDelegate(self)
        dockController.setDelegate(self)
    }
    
    private func openCloseDropdownMenu() {
        homeScreen.dropdownMenu.isShow = !homeScreen.dropdownMenu.isShow
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
        homeScreen.dropdownMenu.setSectionFooterHeight(forSection: lastSection, 1)
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
        return homeScreen.createRightRowView(rightImage, Theme.shared.currentTheme.onSurface)
    }
    
    private func addChevronToSubMenu(_ subMenu: DropdownMenuData ) -> UIView? {
        if !subMenu.isEmpty {
            return homeScreen.createRightRowView("chevron.forward", Theme.shared.currentTheme.onSurfaceVariant)
        }
        return nil
    }
    
    private func addHeartToFavorites() -> UIView? {
        guard let resultDropdownMenu else { return nil }
        if (resultDropdownMenu[self.indexSection].section == HomeViewController.favoritesID) {
            return homeScreen.createRightRowView("heart.fill", Theme.shared.currentTheme.onSurface)
        }
        return nil
    }
    
    private func showCategoriesViewController(_ subMenu: DropdownMenuData) {
        categoriesVC = CategoriesViewController(subMenu)
        configCategoriesDelegate()
        if let categoriesVC {
            categoriesVC.modalPresentationStyle = .fullScreen
            self.navigationController?.present(categoriesVC, animated: true)
        }
    }
    
    private func configCategoriesDelegate() {
        if let categoriesVC {
            categoriesVC.delegate = self
        }
    }
    
    private func openCategories() {
        guard let resultDropdownMenu else {return}
        guard let items = resultDropdownMenu[rowTappedDropdownMenu.section].items else { return }
        if items[rowTappedDropdownMenu.row].title == HomeViewController.categoriesID {
            self.categories = items[rowTappedDropdownMenu.row].subMenu ?? []
            showCategoriesViewController(categories)
        }
    }
    

    
    private func getIcon(_ index: Int) -> String {
        let win = floatManager.listFloatView[index]
        let idApp = win.customAttribute as! String
        return getImageById(idApp)
    }
    
    private func getImageById(_ idApp: String) -> String {
        let filteredItems = categories
            .compactMap { $0.items?.compactMap { $0 } }
            .flatMap { $0 }
            .filter { $0.id == idApp }.first
        return filteredItems?.leftImage ?? ""
    }
    
    
    //  MARK: - FLOATWINDOW Area
    
    private func addFloatViewController(_ category: (section: Int, row: Int)) {
        let idApp: String = getIdAppByCategory(category)
        hideElementsOnScreen()
        delegateFloatViewController?.openFloatViewController(idApp, where: homeScreen.viewFloatWindow.view)
    }
    
    private func getIdAppByCategory(_ category: (section: Int, row: Int)) -> String {
        return self.categories[category.section].items?[category.row].id ?? ""
    }
    
    
    lazy var textField: TextFieldBuilder = {
        let txt = TextFieldBuilder()
            .setKeyboard({ buid in
                buid
                    .setKeyboardType(.decimalPad)
            })
            .setBorder({ build in
                build
                    .setWidth(1)
            })
            .setConstraints { build in
                build
                    .setAlignmentCenterXY.equalToSuperView
                    .setSize.equalToConstant(50)
            }
        return txt
    }()
    
}
    



//  MARK: - EXTENSION HomeViewDelegate

extension HomeViewController: HomeViewDelegate {
    func openMenu() {
        self.homeScreen.turnOnMenuButton()
    }
    
    func closeMenu() {
        self.homeScreen.turnOffMenuButton()
    }
       
    func dropdownMenuTapped(_ rowTapped: (section: Int, row: Int)) {
        self.rowTappedDropdownMenu = rowTapped
        openCategories()
    }
    
    func menuButtonTapped() {
        openCloseDropdownMenu()
    }
    
}


//  MARK: - Extension CATEGORIES-VIEW-CONTROLLER-DELEGATE

extension HomeViewController: CategoriesViewControllerDelegate {
    
    func selectedCategory(_ section: Int, _ row: Int) {
        openCloseDropdownMenu()
        rowTappedCategory = (section,row)
    }

}


//  MARK: - Extension FLOATWINDOW-MANAGER-DELEGATE

extension HomeViewController: FloatViewControllerManagerDelegate {

    func viewWillAppear(_ floatView: FloatViewController) {
        dockController.insertItem(floatManager.countFloatView - 1)
    }
    
    func viewDidAppear(_ floatView: FloatViewController) {
        dockController.verifyShowDock()
    }
    
    func viewDidSelectFloatView(_ floatView: FloatViewController) {
        if let index = floatManager.getIndex(floatView) {
            dockController.selectItem(index, at: .centeredHorizontally)
        }
    }
    
    func viewDidDeselectFloatView(_ floatView: FloatViewController) {
        if let index = floatManager.getIndex(floatView) {
            dockController.deselect(index)
        }
    }
    
    func viewWillDisappear(_ floatView: FloatViewController) {
        self.indexCloseWin = floatManager.getIndex(floatView)
    }

    func viewDidDisappear(_ floatView: FloatViewController) {
        dockController.verifyShowDock()
        verifyShowElementsOnScreen()
        if let indexCloseWin {
            dockController.removeItem(indexCloseWin)
        }
    }
    
    func viewWillMinimize(_ floatView: FloatViewController) {
        dockController.minimizedItemDock(floatView)
    }
    
    func viewDidMinimize(_ floatView: FloatViewController) {
        dockController.verifyShowDock()
        verifyShowElementsOnScreen()
    }
    
    func viewWillRestore(_ floatView: FloatViewController) {
        dockController.restoredItemDock(floatView)
        hideElementsOnScreen()
    }
    
    func viewDidRestore(_ floatView: FloatViewController) {
        dockController.verifyShowDock()
    }
    
    func allClosedWindows() {
        showElementsOnScreen()
    }
    
    private func verifyShowElementsOnScreen() {
        if FloatViewControllerManager.instance.isAllMinimized() {
            showElementsOnScreen()
            return
        }
        hideElementsOnScreen()
    }

    private func hideElementsOnScreen() {
        homeScreen.clock.setOpacity(0.6)
        homeScreen.weather.setHidden(true)
        homeScreen.askChatGPTView.setHidden(true)
    }
    
    private func showElementsOnScreen() {
        homeScreen.clock.setOpacity(1)
        homeScreen.weather.setHidden(false)
        homeScreen.askChatGPTView.setHidden(false)
    }

}


//  MARK: - Extension DOCK DELEGATE

extension HomeViewController: DockDelegate {
    
    func numberOfItemsCallback() -> Int {
        return floatManager.countFloatView
    }
    
    func cellItemCallback(_ indexItem: Int) -> UIView {
        let img = getIcon(indexItem)
        let iconDock = homeScreen.createIconsDock(img)
        dockController.configItemDock(indexItem)
        return iconDock
    }
    
    func shouldSelectItemAt(_ indexItem: Int) -> Bool {
        let floatView = floatManager.listFloatView[indexItem]
        if dockController.isSelected(indexItem) {
            floatView.minimize
            return false
        }
        return true
    }
    
    func didSelectItemAt(_ indexItem: Int) {
        dockController.setShadowItemDock()
        activeFloatView(indexItem)
    }
    
    func didDeselectItemAt(_ indexItem: Int) {
        dockController.removeShadowItemDock(indexItem)
    }
    
    
    private func activeFloatView(_ indexItem: Int)  {
        let floatView = floatManager.listFloatView[indexItem]
        
        if floatView.isMinimized {
            floatView.restore
            return
        }
        
        floatView.select
    }

}
