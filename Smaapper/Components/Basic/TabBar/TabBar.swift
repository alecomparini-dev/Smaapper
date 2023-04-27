//
//  TabBar.swift
//  BackFront-BFNFT
//
//  Created by Alessandro Comparini on 03/04/23.
//

import UIKit

class TabBar: UITabBarController {
    
    private let tabBarVM = TabBarViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        build()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        build()
    }
    
    
//  MARK: - SET PROPERTIES OF COMPONENT
    
//    func setItem(_ item: UIViewController, _ imageItem: ImageView) -> Self {
//        tabBarVM.items(item, imageItem)
//        return self
//    }
    
    func useNavigationController() -> Self {
        tabBarVM.useNavigationController = true
        return self
    }
    
    func enableUnderlineOnChosenItem() -> Self {
        tabBarVM.activateUnderline = true
        return self
    }
    
    func setTranslucent( _ value: Bool) -> Self {
        tabBarVM.isTranslucent = value
        return self
    }
    
    func setTintColor( _ color: UIColor) -> Self {
        tabBarVM.tintColor = color
        return self
    }
    
    func setBackgroundColor( _ color: UIColor) -> Self {
        tabBarVM.backgroundColor = color
        return self
    }
    
    func setUnselectedItemTintColor( _ color: UIColor) -> Self {
        tabBarVM.unselectedItemTintColor = color
        return self
    }
    
    
//  MARK: - BUILD COMPONENT
    func build() -> Self {
        buildItem()
        buildUseNavigationController()
        buildTranslucent()
        buildBackgroundColor()
        buildTintColor()
        buildUnselectedItemTintColor()
        buildActivateUnderline()
        return self
    }
    
    private func buildItem() {
        if tabBarVM.useNavigationController { return }
        let items: [TabBarItemModel] = getItems()
        var itemViewController: [UIViewController] = []
        items.forEach { element in
            itemViewController.append(element.item)
        }
        setViewControllers(itemViewController, animated: true)
        setImages(items)
    }
    
    private func buildUseNavigationController() {
        if !tabBarVM.useNavigationController { return }
        let items: [TabBarItemModel] = getItems()
        
        var itemNavController: [UINavigationController] = []
        items.forEach { element in
            itemNavController.append(UINavigationController(rootViewController:  element.item))
        }
        setViewControllers(itemNavController, animated: true)
        setImages(items)
    }
    
    private func buildTranslucent() {
        tabBar.isTranslucent = tabBarVM.isTranslucent
    }
    
    private func buildTintColor() {
        if let tintColor = tabBarVM.tintColor {
            tabBar.tintColor = tintColor
        }
    }
    
    private func buildUnselectedItemTintColor() {
        if let unselectedTintColor = tabBarVM.unselectedItemTintColor {
            tabBar.unselectedItemTintColor = unselectedTintColor
        }
    }
    
    private func buildBackgroundColor() {
        if let backgroundColor = tabBarVM.backgroundColor {
            tabBar.backgroundColor = backgroundColor
        }
    }
    
    private func buildActivateUnderline() {
        if !tabBarVM.activateUnderline { return }
        DispatchQueue.main.async {
            self.configUnderline()
        }
        
    }
    
    
    
//  MARK: - METHODS OF COMPONENTS
    
    private func getItems() -> [TabBarItemModel] {
        return tabBarVM.items
    }
    
    private func setImages(_ items: [TabBarItemModel]) {
//        items.enumerated().forEach { index, item in
//            tabBar.items?[index].image = item.imageView.view.image
//        }
    }

    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        setUnderline(tabBar, item)
    }
    
    
// MARK: - ENABLE UNDERLINE
    
    private func configUnderline() {
        // Crie o sublinhado
        let underlineWidth: CGFloat = 35
        let underlineHeight: CGFloat = 2
        let underlineXPosition = tabBar.frame.width / CGFloat(tabBar.items!.count) * CGFloat(0) + (tabBar.frame.width / CGFloat(tabBar.items!.count) - underlineWidth) / 2
        let underlineYPosition = tabBar.frame.height - ((view.frame.height - view.safeAreaLayoutGuide.layoutFrame.height)/2)

        let underlineView = UIView(frame: CGRect(x: underlineXPosition, y: underlineYPosition, width: underlineWidth, height: underlineHeight))
        
        underlineView.backgroundColor = tabBarVM.tintColor?.withAlphaComponent(0.8)
        
        // Adicione o sublinhado como uma subvisualização da UITabBar
        tabBar.addSubview(underlineView)
        
        // Defina o sublinhado como a primeira subvisualização para que ele apareça na frente dos itens da barra de guias
        tabBar.sendSubviewToBack(underlineView)
    }
    
    private func setUnderline(_ tabBar: UITabBar, _ item: UITabBarItem) {
        // Encontre o índice do item selecionado
        guard let index = tabBar.items?.firstIndex(of: item) else { return }

        // Calcule a posição do sublinhado
        let underlineWidth: CGFloat = 35
        let underlineHeight: CGFloat = 2
        let underlineXPosition = tabBar.frame.width / CGFloat(tabBar.items!.count) * CGFloat(index) + (tabBar.frame.width / CGFloat(tabBar.items!.count) - underlineWidth) / 2

        //MINHA ADAPTACAO PARA PODER O SUBLINHADO FICAR EXATAMENTE ABAIXO DO ICONE
        let underlineYPosition = tabBar.frame.height - ((view.frame.height - view.safeAreaLayoutGuide.layoutFrame.height)/2)

        // Mova o sublinhado para a posição do item selecionado
        for subview in tabBar.subviews {
            if subview.backgroundColor == tabBarVM.tintColor?.withAlphaComponent(0.8) {
                subview.frame = CGRect(x: underlineXPosition, y: underlineYPosition, width: underlineWidth, height: underlineHeight)
            }
        }
    }
    
}
