//
//  Dock.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 16/05/23.
//

import UIKit

class Dock: View {
    
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
    
    
    var att: DockAttributes
    
    init(numberOfItemsCallback: @escaping () -> Int, cellCallback: @escaping cellCallbackAlias ) {
        self.att = DockAttributes()
        self.numberOfItemsCallback = numberOfItemsCallback
        self.cellCallback = cellCallback
        super.init()
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
        att.collection.register(DockCell.self, forCellWithReuseIdentifier: DockCell.identifier)
    }
    
    private func setDelegate() {
        att.collection.delegate = self
        att.collection.dataSource = self
    }
    
    private func configDock() {
        applyBlur()
        addElementsInDock()
        configConstraints()
        
    }
    
    private func addElementsInDock() {
        att.container.add(insideTo: self)
        att.collection.add(insideTo: att.container)
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
        customConstraintWidthContainer = att.container.widthAnchor.constraint(equalToConstant: 0)
        customConstraintWidthContainer.isActive = true
    }
    
    private func applyConstraintContainer() {
        att.container.makeConstraints { make in
            make
                .setTop.equalTo(self, .top)
                .setHorizontalAlignmentX.equalTo(self)
                .setHeight.equalTo(self)
        }
    }
    
    private func configConstraintsCollection() {
        att.collection.makeConstraints { make in
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
            return (numberOfItems.toCGFloat - 1) * (att.layout.minimumLineSpacing)
        }
        return 0.0
    }
    
    private func calculateContentInset() -> CGFloat {
        return att.collection.contentInset.left + att.collection.contentInset.right
    }
    
    private func calculateItemSize() -> CGFloat {
        let customItemSize = calculateCustomItemSize()
        let itemSize = calculateItemSizeExcludingCustomItemSize()
        return customItemSize + itemSize
    }
    
    private func calculateCustomItemSize() -> CGFloat {
        return self.att.customItemSize.reduce(0) { $0 + $1.value.width }
    }
    
    private func calculateItemSizeExcludingCustomItemSize() -> CGFloat {
        return (self.numberOfItemsCallback() - self.att.customItemSize.count).toCGFloat * att.itemsSize.width
    }
    
    private func applyBlur() {
        if !att.blurEnabled { return }
        att.container.makeBlur { make in
            make.setStyle(.dark)
                .apply()
        }
    }
    
}



//  MARK: - Extension Delegate Flow Layout
extension Dock: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.att.customItemSize[indexPath.row] ?? self.att.itemsSize
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
        item.isUserInteractionEnabled = self.att.isUserInteractionEnabledItems
        cell.setupCell(item)
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }

}


