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
    private var customConstraintWidthCollection: NSLayoutConstraint = NSLayoutConstraint()
    private var isUserInteractionEnabledItems = false
    
    private var items: [IconButton] = [
        IconButton(UIImageView(image: UIImage(systemName: "mic"))),
        IconButton(UIImageView(image: UIImage(systemName: "person"))),
        IconButton(UIImageView(image: UIImage(systemName: "trash"))),
        IconButton(UIImageView(image: UIImage(systemName: "trash"))),
        IconButton(UIImageView(image: UIImage(systemName: "person.fill"))),
        IconButton(UIImageView(image: UIImage(systemName: "person.circle"))),
        IconButton(UIImageView(image: UIImage(systemName: "trash"))),
        IconButton(UIImageView(image: UIImage(systemName: "person"))),
        IconButton(UIImageView(image: UIImage(systemName: "trash"))),
        IconButton(UIImageView(image: UIImage(systemName: "trash"))),
        IconButton(UIImageView(image: UIImage(systemName: "person.fill"))),
        IconButton(UIImageView(image: UIImage(systemName: "person.circle"))),
        IconButton(UIImageView(image: UIImage(systemName: "trash"))),
        IconButton(UIImageView(image: UIImage(systemName: "mic"))),
        IconButton(UIImageView(image: UIImage(systemName: "trash"))),
        IconButton(UIImageView(image: UIImage(systemName: "person")))
    ]
    private var customItemSize: [Int:CGSize] = [:]
    private var itemsSize = CGSize(width: 50, height: 50)

    private let collection: UICollectionView
    
    override init() {
        self.layout = UICollectionViewFlowLayout()
        self.collection = UICollectionView(frame: .zero, collectionViewLayout: self.layout)
        super.init(frame: .zero)
        self.initialization()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialization() {
        self.collection.backgroundColor = .clear
        self.layout.scrollDirection = .horizontal
        self.collection.setCollectionViewLayout(self.layout, animated: true)
        self.customConstraintWidthCollection = self.collection.widthAnchor.constraint(equalToConstant: 0)
        self.setMinimumLineSpacing(10)
        self.setContentInset(top: 0, left: 10, bottom: 0, rigth: 10)
        self.setShowsHorizontalScrollIndicator(false)
        
    }
    
    var content: UIView { self.collection}
    
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
    
    @discardableResult
    func setIsUserInteractionEnabledItems(_ isUserInteractionEnabled: Bool) -> Self {
        self.isUserInteractionEnabledItems = isUserInteractionEnabled
        return self
    }
    
    
    
    
    @discardableResult
    override func setBorder(_ border: (_ build: Border) -> Border) -> Self {
        let _ = border(Border(self.container))
        return self
    }
    
    @discardableResult
    override func setShadow(_ shadow: (_ build: Shadow) -> Shadow) -> Self {
        let _ = shadow(Shadow(self.container))
        return self
    }
    
    @discardableResult
    override func setNeumorphism(_ neumorphism: (_ build: Neumorphism) -> Neumorphism) -> Self {
        let _ = neumorphism(Neumorphism(self.container))
        return self
    }
    
    @discardableResult
    override func setGradient(_ gradient: (_ build: Gradient) -> Gradient) -> Self {
        let _ = gradient(Gradient(self.container))
        return self
    }
    
    @discardableResult
    override func setTapGesture(_ gesture: (_ build: TapGesture) -> TapGesture) -> Self {
        let _ = gesture(TapGesture(self.container))
        return self
    }
    
    
    
    
//  MARK: - Private Function Area
    
    private func applyOnceConfig() {
        if self._isShow && !alreadyApplied {
            DispatchQueue.main.async {
                self.configCollection()
                self.RegisterCell()
                self.setDelegate()
                self.alreadyApplied = true
            }
            
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
        container.add(insideTo: self)
        self.collection.add(insideTo: container)
    }
    
    private func configConstraintsCollection() {
        self.container.makeConstraints { make in
            make
                .setPin.equalTo(self)
        }
        
        self.collection.makeConstraints { make in
            make
                .setTop.equalTo(container, .top)
                .setHorizontalAlignmentX.equalTo(container)
                .setHeight.equalTo(container)
        }
        
        self.customConstraintWidthCollection.isActive = true
        configConstraintWidthContainer()
    }
    
    private func configConstraintWidthContainer() {
        self.dockViewBounds = self.bounds
        let sizeAllItems = self.calculateSizeAllItems()
        if sizeAllItems >= self.dockViewBounds.width {
            self.customConstraintWidthCollection.constant = self.dockViewBounds.width
        } else {
            self.customConstraintWidthCollection.constant = sizeAllItems
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



//  MARK: - Extension Delegate Flow Layout
extension Dock: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.customItemSize[indexPath.row] ?? itemsSize
    }
    
}


//  MARK: - Extension Delegate
extension Dock: UICollectionViewDelegate {
    
    
    
}



//  MARK: - Extension DataSource
extension Dock: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DockCell.identifier, for: indexPath) as! DockCell
        
        let item = self.items[indexPath.row]
        item.isUserInteractionEnabled = self.isUserInteractionEnabledItems
        cell.setupCell(item)
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
}


