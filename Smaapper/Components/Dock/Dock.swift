//
//  Dock.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 16/05/23.
//

import UIKit

class Dock: View {
    
    private var _isShow = false
    private var alreadyApplied = false
    
    private var dockViewBounds = CGRect()

    private let layout: UICollectionViewFlowLayout
    private let container = UIView()
    private var customConstraintWidthCollectioin: NSLayoutConstraint = NSLayoutConstraint()
    
    private var items: [IconButton] = [
        IconButton(UIImageView(image: UIImage(systemName: "mic"))),
//        IconButton(UIImageView(image: UIImage(systemName: "person"))),
//        IconButton(UIImageView(image: UIImage(systemName: "trash"))),
//        IconButton(UIImageView(image: UIImage(systemName: "trash"))),
//        IconButton(UIImageView(image: UIImage(systemName: "person.fill"))),
//        IconButton(UIImageView(image: UIImage(systemName: "person.cicle"))),
//        IconButton(UIImageView(image: UIImage(systemName: "trash"))),
//        IconButton(UIImageView(image: UIImage(systemName: "mic"))),
//        IconButton(UIImageView(image: UIImage(systemName: "trash"))),
        IconButton(UIImageView(image: UIImage(systemName: "person")))
    ]
    private var customItemSize: [Int:CGSize] = [:]
    private var itemsSize = CGSize(width: 50, height: 50)

    let collection: UICollectionView
    
    override init() {
        self.layout = UICollectionViewFlowLayout()
        self.collection = UICollectionView(frame: .zero, collectionViewLayout: self.layout)
        super.init()
        self.initialization()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialization() {
        self.collection.setCollectionViewLayout(self.layout, animated: true)
        self.layout.scrollDirection = .horizontal
        self.customConstraintWidthCollectioin = self.collection.widthAnchor.constraint(equalToConstant: 0)
        self.setMinimumLineSpacing(10)
        self.setContentInset(top: 0, left: 10, bottom: 0, rigth: 10)
        
        self.collection.backgroundColor = .red
    }
    
    var isShow: Bool {
        get { return self._isShow}
        set {
            self._isShow = newValue
            applyOnceConfig()
            self.isHidden = !_isShow
        }
    }
    

    
//  MARK: - SET Properties

    @discardableResult
    func setItems(_ item: IconButton) -> Self {
        self.items.append(item)
        return self
    }
    
    @discardableResult
    func setSize(indexItem: Int, _ size: CGSize) -> Self {
        self.customItemSize.updateValue(size, forKey: indexItem)
        return self
    }
    
    @discardableResult
    func setSize(_ size: CGSize) -> Self {
        self.itemsSize = size
        return self
    }
    
    @discardableResult
    func setShowsHorizontalScrollIndicator(_ flag: Bool) -> Self {
        self.collection.showsHorizontalScrollIndicator = flag
        return self
    }
    
    @discardableResult
    func setContentInset(top: CGFloat, left: CGFloat, bottom: CGFloat, rigth: CGFloat) -> Self {
        self.collection.contentInset = UIEdgeInsets(top: top, left: left, bottom: bottom, right: rigth)
        return self
    }
    
    @discardableResult
    func setContentInsetAdjustmentBehavior(_ insetAdjustment: UIScrollView.ContentInsetAdjustmentBehavior ) -> Self {
        self.collection.contentInsetAdjustmentBehavior = insetAdjustment
        return self
    }
    
    @discardableResult
    func setMinimumLineSpacing(_ minimumSpacing: CGFloat) -> Self {
        self.layout.minimumLineSpacing = minimumSpacing
        return self
    }
    

    
//  MARK: - Private Function Area
    
    private func applyOnceConfig() {
        if self._isShow && !alreadyApplied {
            self.RegisterCell()
            DispatchQueue.main.async {
                self.configCollection()
                self.setDelegate()
            }
            alreadyApplied = true
        }
    }
    
    private func RegisterCell() {
        self.collection.register(DockCell.self, forCellWithReuseIdentifier: DockCell.identifier)
    }
    
    private func setDelegate() {
        collection.delegate = self
        collection.dataSource = self
    }
    
    private func configCollection() {
        addCollectionInDockView()
        configConstraintsCollection()
    }
    
    
    private func addCollectionInDockView() {
        self.collection.add(insideTo: self)
    }
    
    private func configConstraintsCollection() {
        self.collection.makeConstraints { make in
            make
                .setHorizontalAlignmentX.equalTo(self)
                .setHeight.equalTo(self)
        }
        self.customConstraintWidthCollectioin.isActive = true
        configConstraintWidthCollection()
    }
    
    private func configConstraintWidthCollection() {
        self.dockViewBounds = self.bounds
        let sizeAllItems = self.calculateSizeAllItems()
        if sizeAllItems >= self.dockViewBounds.width {
            self.customConstraintWidthCollectioin.constant = self.dockViewBounds.width
        } else {
            self.customConstraintWidthCollectioin.constant = sizeAllItems
        }
    }
    
    private func calculateSizeAllItems() -> CGFloat {
        let spacing = calculateLineSpacing()
        let contentInset = calculateContentInset()
        let itemSize = calculateItemSize()
        return itemSize + spacing + contentInset
    }
    
    private func calculateLineSpacing() -> CGFloat {
        if self.items.count > 1 {
            return (self.items.count.toCGFloat - 1) * layout.minimumLineSpacing
        }
        return 0.0
    }
    
    private func calculateContentInset() -> CGFloat {
        return self.collection.contentInset.left + self.collection.contentInset.right
    }
    
    private func calculateItemSize() -> CGFloat {
        let customItemSize = calculateCustomItemSize()
        let itemSize = calculateItemSizeExcludingCustomItemSize()
        return customItemSize + itemSize
    }
    
    private func calculateCustomItemSize() -> CGFloat {
        return self.customItemSize.reduce(0) { $0 + $1.value.width }
    }
    
    private func calculateItemSizeExcludingCustomItemSize() -> CGFloat {
        return (self.items.count - self.customItemSize.count).toCGFloat * itemsSize.width
    }
    
}


//  MARK: - Extension Delegate
extension Dock: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.customItemSize[indexPath.row] ?? itemsSize
    }
    
}



//  MARK: - Extension DataSource
extension Dock: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DockCell.identifier, for: indexPath) as! DockCell
        
        cell.setupCell(self.items[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    
}

//  MARK: - Extension FlowLayout
extension Dock: UICollectionViewDelegateFlowLayout {
    

    
}