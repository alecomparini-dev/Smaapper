//
//  Dock.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 16/05/23.
//

import UIKit

class Dock: View {
    
    enum State {
        case show
        case hide
    }
    
    typealias cellCallbackAlias = (_ indexItem: Int) -> UIView
    typealias numberOfItemsCallbackAlias = () -> Int
    
    private let hierarchy: CGFloat = 1100
    private let marginContainer: CGFloat = 8
    
    private var _isShow = false
    private var alreadyApplied = false
    
    private var dockViewBounds = CGRect()
    private var customConstraintWidthContainer: NSLayoutConstraint = NSLayoutConstraint()
    
    private let numberOfItemsCallback: numberOfItemsCallbackAlias
    private let cellCallback: cellCallbackAlias
    
    var attributes: DockAttributes = DockAttributes()
    
    init(numberOfItemsCallback: @escaping () -> Int, cellCallback: @escaping cellCallbackAlias ) {
        self.numberOfItemsCallback = numberOfItemsCallback
        self.cellCallback = cellCallback
        super.init(frame: .zero)
        self.attributes = DockAttributes(self)
        self.initialization()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialization() {
        self.layer.zPosition = hierarchy
    }
    
    var isShow: Bool {
        get { return self._isShow}
        set {
            self._isShow = newValue
            applyOnceConfig()
            self.isHidden = !_isShow
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
        attributes.collection.register(DockCell.self, forCellWithReuseIdentifier: DockCell.identifier)
    }
    
    private func setDelegate() {
        attributes.collection.delegate = self
        attributes.collection.dataSource = self
    }
    
    private func configDock() {
        applyBlur()
        addElementsInDock()
        configConstraints()
    }
    
    private func addElementsInDock() {
        attributes.container.add(insideTo: self)
        attributes.collection.add(insideTo: attributes.container)
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
        self.dockViewBounds = self.bounds
    }
    
    private func initializeWidthConstraintContainer() {
        customConstraintWidthContainer = attributes.container.widthAnchor.constraint(equalToConstant: 0)
        customConstraintWidthContainer.isActive = true
    }
    
    private func applyConstraintContainer() {
        attributes.container.makeConstraints { make in
            make
                .setTop.equalTo(self, .top)
                .setHorizontalAlignmentX.equalTo(self)
                .setHeight.equalTo(self)
        }
    }
    
    private func configConstraintsCollection() {
        attributes.collection.makeConstraints { make in
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
        let numberOfItems = self.numberOfItemsCallback()
        if numberOfItems > 1 {
            return (numberOfItems.toCGFloat - 1) * (attributes.layout.minimumLineSpacing)
        }
        return 0.0
    }
    
    private func calculateContentInset() -> CGFloat {
        return (attributes.collection.contentInset.left) + (attributes.collection.contentInset.right)
    }
    
    private func calculateItemSize() -> CGFloat {
        let customItemSize = calculateCustomItemSize()
        let itemSize = calculateItemSizeExcludingCustomItemSize()
        return customItemSize + itemSize
    }
    
    private func calculateCustomItemSize() -> CGFloat {
        return attributes.customItemSize.reduce(0) { $0 + $1.value.width }
    }
    
    private func calculateItemSizeExcludingCustomItemSize() -> CGFloat {
        return (self.numberOfItemsCallback() - (self.attributes.customItemSize.count)).toCGFloat * (attributes.itemsSize.width)
    }
    
    private func applyBlur() {
        if !attributes.blurEnabled { return }
        attributes.container.makeBlur { make in
            make
                .setStyle(.dark)
                .setOpacity(self.attributes.opacity)
                .apply()
        }
    }
    
}


//  MARK: - Extension Delegate Flow Layout
extension Dock: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return attributes.customItemSize[indexPath.row] ?? attributes.itemsSize
    }
    
}


//  MARK: - Extension Delegate
extension Dock: UICollectionViewDelegate {
    
}



//  MARK: - Extension DataSource
extension Dock: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.numberOfItemsCallback()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DockCell.identifier, for: indexPath) as! DockCell
        let item = self.cellCallback(indexPath.row)
        item.isUserInteractionEnabled = self.attributes.isUserInteractionEnabledItems
        cell.setupCell(item)
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }

}


