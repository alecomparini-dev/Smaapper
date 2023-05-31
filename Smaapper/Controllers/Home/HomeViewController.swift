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
    
    
    private let iconsDock = ["paperplane.fill",
                             "square.and.arrow.up.trianglebadge.exclamationmark",
                             "paintbrush.fill",
                             "die.face.5",
                             "pianokeys.inverse",
                             "level.fill",
                             "puzzlepiece.extension",
                             "fan.oscillation.fill",
                             "light.beacon.max.fill",
                             "door.left.hand.closed",
                             "eraser.fill",
                             "xmark.seal",
                             "scribble",
                             "bolt.horizontal" ]
    
    private let viewModel = HomeViewModel()
    
    private var adjustTrailingDock = NSLayoutConstraint()
    
    private var resultDropdownMenu: DropdownMenuData?
    private var turnOnMenuButton = false
    private var indexSection = 0
    private var indexRow = 0
    private var rowTapped: (section: Int, row: Int) = (0,0)
    
    lazy var homeScreen: HomeView = {
        let home = HomeView(frame: .zero)
        return home
    }()
    
   
    override func loadView() {
        view = homeScreen.view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configDelegate()
        fetchDropdownMenu()
        configRowsHeightOfDropdowMenu()
        setConstraintAlignmentHorizontalDock()
        homeScreen.dropdownMenu.isShow = false
        
        let weather = WeatherViewController(frame: CGRect(x: 80, y: 350, width: 200, height: 350))
        weather.present(insideTo: self.view)

        
        drag()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        adjustAlignmentOfDock()
        homeScreen.dock.isShow = true
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    //  MARK: - Private Function Area
    private func setConstraintAlignmentHorizontalDock() {
        self.adjustTrailingDock = homeScreen.dock.view.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        adjustTrailingDock.isActive = true
    }
    
    private func configDelegate() {
        homeScreen.delegate = self
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
        if (resultDropdownMenu[self.indexSection].section == HomeVC.favoritesID) {
            return homeScreen.createRightRowView("heart.fill", Theme.shared.currentTheme.onSurface)
        }
        return nil
    }
    
    private func showCategoriesViewController(_ subMenu: DropdownMenuData) {
        let categoriesVC = CategoriesViewController(subMenu)
        categoriesVC.modalPresentationStyle = .fullScreen
        present(categoriesVC, animated: true)
    }
    
    
    private func adjustAlignmentOfDock() {
        if iconsDock.count == 4 {
            self.adjustTrailingDock.constant = -50
        }
        
        if iconsDock.count > 4 {
            self.adjustTrailingDock.constant = -90
        }

    }
    
    private func openCategories() {
        guard let resultDropdownMenu else {return}
        guard let items = resultDropdownMenu[rowTapped.section].items else { return }
        if items[rowTapped.row].title == HomeVC.categoriesID {
            guard let subMenu = items[rowTapped.row].subMenu else { return }
            showCategoriesViewController(subMenu)
        }   
    }
    
    
    
    
    
    
    
    
    
        
    
        private var draggableLabel: UILabel!
        private var originalPosition: CGPoint = .zero

        private func drag() {
            
            // Crie uma label draggable
            draggableLabel = UILabel(frame: CGRect(x: 100, y: 100, width: 150, height: 200))
            draggableLabel.text = "Arraste-me"
            draggableLabel.backgroundColor = .red
            draggableLabel.textColor = .white
            draggableLabel.textAlignment = .center
            draggableLabel.isUserInteractionEnabled = true
            
            
            // Adicione o UIPanGestureRecognizer à label
            let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
            draggableLabel.addGestureRecognizer(panGesture)
            
            view.addSubview(draggableLabel)
            
            BorderBuilder(draggableLabel)
                .setCornerRadius(20)
            
            
        }

        
    @objc func handlePan(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        
        switch gesture.state {
        case .began:
            // Salve a posição original da label
            originalPosition = draggableLabel.center
            
        case .changed:
            // Atualize a posição da label com base no gesto de arrastar
            let newPosition = CGPoint(x: originalPosition.x + translation.x, y: originalPosition.y + translation.y)
            draggableLabel.center = newPosition
            
        case .ended:
            break
            
        default:
            break
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
}


//  MARK: - Extension HomeViewDelegate

extension HomeVC: HomeViewDelegate {
    func openMenu() {
        self.homeScreen.turnOnMenuButton()
    }
    
    func closeMenu() {
        self.homeScreen.turnOffMenuButton()
    }
    
    func numberOfItemsCallback() -> Int {
        return self.iconsDock.count
    }
    
    func dockCellCalback(_ indexCell: Int) -> UIView {
        return homeScreen.createIconsDock(iconsDock[indexCell])
    }
    
    func dropdownMenuTapped(_ rowTapped: (section: Int, row: Int)) {
        self.rowTapped = rowTapped
        openCategories()
    }
    
    func menuButtonTapped() {
        openCloseDropdownMenu()
    }
    
}
