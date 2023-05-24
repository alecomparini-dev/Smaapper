//
//  DockAttributes.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 23/05/23.
//

import UIKit

class DockAttributes: BaseComponentAttributes<Dock> {
    
//  MARK: - Model - Need Refactor
    private var _customItemSize: [Int:CGSize] = [:]
    private var _itemsSize = CGSize(width: 50, height: 50)
    private var _isUserInteractionEnabledItems = false
    private var _blurEnabled = false
    private var _opacity: CGFloat = 1.0

    private var _layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    private let _container = UIView()
    private var _collection: UICollectionView = UICollectionView(frame: .zero,collectionViewLayout: UICollectionViewFlowLayout())
    
    private weak var dock: Dock?
    
    override init(_ dock: Dock) {
        self.dock = dock
        super.init(dock)
        self.initialization()
    }
    
    override init() {
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialization() {
        initiateContainer()
        initiateLayout()
        initiateCollection()
        setDefault()
    }
    
    private func initiateCollection() {
        self._collection.setCollectionViewLayout(self._layout, animated: true)
        self._collection.backgroundColor = .clear
    }
    
    private func initiateContainer() {
        self._container.clipsToBounds = true
    }
    
    private func initiateLayout() {
        self._layout.scrollDirection = .horizontal
    }
    
    
    private func setDefault() {
        
        self.setMinimumLineSpacing(10)
        self.setContentInset(top: 10, left: 10, bottom: 10, rigth: 10)
        self.setShowsHorizontalScrollIndicator(false)
    }
    

//  MARK: - GET Properties
    var layout: UICollectionViewFlowLayout { return self._layout}
    var container: UIView { return self._container}
    var collection: UICollectionView { return self._collection}
    var customItemSize: [Int:CGSize] { return self._customItemSize}
    var itemsSize: CGSize { return self._itemsSize}
    var isUserInteractionEnabledItems: Bool { return self._isUserInteractionEnabledItems}
    var blurEnabled: Bool { return self._blurEnabled}
    var opacity: CGFloat { return self._opacity}
    
    
//  MARK: - SET Properties
    
    @discardableResult
    func setSize(indexItem: Int, _ size: CGSize) -> Self {
        self._customItemSize.updateValue(size, forKey: indexItem)
        return self
    }
    
    @discardableResult
    func setSize(_ size: CGSize) -> Self {
        self._itemsSize = size
        return self
    }
    
    @discardableResult
    func setShowsHorizontalScrollIndicator(_ flag: Bool) -> Self {
        self._collection.showsHorizontalScrollIndicator = flag
        return self
    }
    
    @discardableResult
    func setContentInset(top: CGFloat, left: CGFloat, bottom: CGFloat, rigth: CGFloat) -> Self {
        self._collection.contentInset = UIEdgeInsets(top: top, left: left, bottom: bottom, right: rigth)
        return self
    }
    
    @discardableResult
    func setContentInsetAdjustmentBehavior(_ insetAdjustment: UIScrollView.ContentInsetAdjustmentBehavior ) -> Self {
        self._collection.contentInsetAdjustmentBehavior = insetAdjustment
        return self
    }
    
    @discardableResult
    func setMinimumLineSpacing(_ minimumSpacing: CGFloat) -> Self {
        self._layout.minimumLineSpacing = minimumSpacing
        return self
    }
    
    @discardableResult
    func setIsUserInteractionEnabledItems(_ isUserInteractionEnabled: Bool) -> Self {
        self._isUserInteractionEnabledItems = isUserInteractionEnabled
        return self
    }
    
    @discardableResult
    func setBlur(_ flag: Bool, _ opacity: CGFloat = 1) -> Self {
        self._blurEnabled = flag
        self._opacity = opacity
        return self
    }
    
    
//  MARK: - OVERRIDE BASE COMPONENT
    override func setBorder(_ border: (BorderBuilder) -> BorderBuilder) -> Dock {
        self.border = border(BorderBuilder(self.container))
        return dock!
    }
    
}
