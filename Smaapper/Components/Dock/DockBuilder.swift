//
//  DockBuilder.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 24/05/23.
//

import UIKit

class DockBuilder: BaseAttributeBuilder {
    
    private var layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    private var container = UIView()
    private let collection: UICollectionView = UICollectionView(frame: .zero,collectionViewLayout: UICollectionViewFlowLayout())
    
    private var dockViewBounds = CGRect()
    private var customConstraintWidthContainer: NSLayoutConstraint = NSLayoutConstraint()

    
    private let hierarchy: CGFloat = 1100
    private let marginContainer: CGFloat = 8
    private var _isShow = false
    private var alreadyApplied = false
    
    private var _dock: Dock
    var dock: Dock { self._dock }
    var view: Dock { self._dock }
    
    init(numberOfItemsCallback: @escaping Dock.numberOfItemsCallbackAlias, cellCallback: @escaping Dock.cellCallbackAlias ) {
        self._dock = Dock(numberOfItemsCallback, cellCallback)
        super.init(self._dock)
        self.initialization()
    }
    
    private func initialization() {
        initiateContainer()
        initiateLayout()
        initiateCollection()
        setHierarchyVisualization()
        setDefault()
        
    }
    
    private func initiateCollection() {
        collection.setCollectionViewLayout(self.layout, animated: true)
        collection.backgroundColor = .clear
    }
    
    private func initiateContainer() {
        container.clipsToBounds = true
    }
    
    private func initiateLayout() {
        layout.scrollDirection = .horizontal
    }
    
    private func setDefault() {
        self.setMinimumLineSpacing(10)
        self.setContentInset(top: 10, left: 10, bottom: 10, rigth: 10)
        self.setShowsHorizontalScrollIndicator(false)
    }
    
    
    private func setHierarchyVisualization() {
        dock.layer.zPosition = hierarchy
    }
    
    //  MARK: - SET Properties
    
    @discardableResult
    func setSize(indexItem: Int, _ size: CGSize) -> Self {
        _dock.customItemSize.updateValue(size, forKey: indexItem)
        return self
    }
    
    @discardableResult
    func setSize(_ size: CGSize) -> Self {
        _dock.itemsSize = size
        return self
    }
    
    @discardableResult
    func setShowsHorizontalScrollIndicator(_ flag: Bool) -> Self {
        collection.showsHorizontalScrollIndicator = flag
        return self
    }
    
    @discardableResult
    func setContentInset(top: CGFloat, left: CGFloat, bottom: CGFloat, rigth: CGFloat) -> Self {
        collection.contentInset = UIEdgeInsets(top: top, left: left, bottom: bottom, right: rigth)
        return self
    }
    
    @discardableResult
    func setContentInsetAdjustmentBehavior(_ insetAdjustment: UIScrollView.ContentInsetAdjustmentBehavior ) -> Self {
        collection.contentInsetAdjustmentBehavior = insetAdjustment
        return self
    }
    
    @discardableResult
    func setMinimumLineSpacing(_ minimumSpacing: CGFloat) -> Self {
        layout.minimumLineSpacing = minimumSpacing
        return self
    }
    
    @discardableResult
    func setIsUserInteractionEnabledItems(_ isUserInteractionEnabled: Bool) -> Self {
        _dock.isUserInteractionEnabledItems = isUserInteractionEnabled
        return self
    }
    
    @discardableResult
    func setBlur(_ flag: Bool, _ opacity: CGFloat = 1) -> Self {
        _dock.blurEnabled = flag
        _dock.opacity = opacity
        return self
    }
    
    
    //  MARK: - SHOW Dock
    var isShow: Bool {
        get { return self._isShow}
        set {
            self._isShow = newValue
            applyOnceConfig()
            _dock.isHidden = !_isShow
        }
    }
    
    
    //  MARK: - Private Function Area
    
    private func applyOnceConfig() {
        if self._isShow && !alreadyApplied {
            DispatchQueue.main.async {
                self.configDock()
                self.RegisterCell()
                self.setDelegate()
                self.alreadyApplied = true
            }
        }
    }
    
    private func RegisterCell() {
        collection.register(DockCell.self, forCellWithReuseIdentifier: DockCell.identifier)
    }
    
    private func setDelegate() {
        collection.delegate = dock
        collection.dataSource = dock
    }
    
    private func configDock() {
        applyBlur()
        addElementsInDock()
        configConstraints()
    }
    
    private func addElementsInDock() {
        container.add(insideTo: dock)
        collection.add(insideTo: container)
    }
    
    private func configConstraints() {
        configConstraintsContainer()
        configConstraintsCollection()
    }
    
    private func configConstraintsContainer() {
        setDockBounds()
        initializeWidthConstraintContainer()
        applyConstraintContainer()
        configConstraintWidthContainer()
    }
    
    private func setDockBounds() {
        self.dockViewBounds = dock.bounds
    }
    
    private func initializeWidthConstraintContainer() {
        customConstraintWidthContainer = container.widthAnchor.constraint(equalToConstant: 0)
        customConstraintWidthContainer.isActive = true
    }
    
    private func applyConstraintContainer() {
        container.makeConstraints { make in
            make
                .setTop.equalTo(dock, .top)
                .setHorizontalAlignmentX.equalTo(dock)
                .setHeight.equalTo(dock)
        }
    }
    
    private func configConstraintsCollection() {
        collection.makeConstraints { make in
            make
                .setTop.setBottom.equalToSuperView
                .setLeading.setTrailing.equalToSuperView(marginContainer)
        }
    }
    
    private func configConstraintWidthContainer() {
        let sizeAllItems = self.calculateSizeAllItems()
        if sizeAllItems >= self.dockViewBounds.width {
            self.customConstraintWidthContainer.constant = self.dockViewBounds.width
        } else {
            self.customConstraintWidthContainer.constant = sizeAllItems
        }
    }
    
    private func calculateSizeAllItems() -> CGFloat {
        let spacing = calculateLineSpacing()
        let contentInset = calculateContentInset()
        let itemSize = calculateItemSize()
        return itemSize + spacing + contentInset + (marginContainer*2)
    }
    
    private func calculateLineSpacing() -> CGFloat {
        let numberOfItems = dock.numberOfItemsCallback()
        if numberOfItems > 1 {
            return (numberOfItems.toCGFloat - 1) * (layout.minimumLineSpacing)
        }
        return 0.0
    }
    
    private func calculateContentInset() -> CGFloat {
        return (collection.contentInset.left) + (collection.contentInset.right)
    }
    
    private func calculateItemSize() -> CGFloat {
        let customItemSize = calculateCustomItemSize()
        let itemSize = calculateItemSizeExcludingCustomItemSize()
        return customItemSize + itemSize
    }
    
    private func calculateCustomItemSize() -> CGFloat {
        return dock.customItemSize.reduce(0) { $0 + $1.value.width }
    }
    
    private func calculateItemSizeExcludingCustomItemSize() -> CGFloat {
        return (dock.numberOfItemsCallback() - (dock.customItemSize.count)).toCGFloat * (dock.itemsSize.width)
    }
    
    private func applyBlur() {
        if !dock.blurEnabled { return }
        container.makeBlur { make in
            make
                .setStyle(.dark)
                .setOpacity(dock.opacity)
                .apply()
        }
    }
    
}


//  MARK: - Extension Delegate Flow Layout
extension Dock: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return customItemSize[indexPath.row] ?? itemsSize
    }
    
}


//  MARK: - Extension DataSource
extension Dock: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfItemsCallback()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DockCell.identifier, for: indexPath) as! DockCell
        let item = self.cellCallback(indexPath.row)
        item.isUserInteractionEnabled = isUserInteractionEnabledItems
        cell.setupCell(item)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
}


