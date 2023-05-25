//
//  Dock_.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 24/05/23.
//

import UIKit

class Dock: UIView {

    enum State {
        case show
        case hide
    }
    
    typealias itemCallbackAlias = (_ indexItem: Int) -> UIView
    typealias numberOfItemsCallbackAlias = () -> Int
    
    private var _customItemSize: [Int:CGSize] = [:]
    private var _itemsSize = CGSize(width: 50, height: 50)
    private var _isUserInteractionEnabledItems = false
    private var _blurEnabled = false
    private var _opacity: CGFloat = 1.0
    
    private let _numberOfItemsCallback: numberOfItemsCallbackAlias
    private let _itemCallback: itemCallbackAlias

    init(_ numberOfItemsCallback: @escaping numberOfItemsCallbackAlias, _ itemCallback: @escaping itemCallbackAlias) {
        self._numberOfItemsCallback = numberOfItemsCallback
        self._itemCallback = itemCallback
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//  MARK: - GET Properties
    
    var customItemSize: [Int:CGSize] {
        get { return self._customItemSize }
        set { self._customItemSize = newValue }
    }
    
    var itemsSize: CGSize {
        get { return self._itemsSize }
        set { self._itemsSize = newValue }
    }
    
    var isUserInteractionEnabledItems: Bool {
        get { return self._isUserInteractionEnabledItems }
        set { self._isUserInteractionEnabledItems = newValue }
    }
    
    var blurEnabled: Bool {
        get { return self._blurEnabled }
        set { self._blurEnabled = newValue }
    }
    
    var opacity: CGFloat {
        get { return self._opacity }
        set { self._opacity = newValue }
    }
        
    var numberOfItemsCallback: numberOfItemsCallbackAlias { self._numberOfItemsCallback }
    var itemCallback: itemCallbackAlias { return self._itemCallback }

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
        let item = self.itemCallback(indexPath.row)
        item.isUserInteractionEnabled = isUserInteractionEnabledItems
        cell.setupCell(item)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
}
