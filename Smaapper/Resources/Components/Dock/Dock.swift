//
//  Dock_.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 24/05/23.
//

import UIKit

protocol DockDelegate: AnyObject {
    func numberOfItemsCallback() -> Int
    func cellItemCallback(_ indexItem: Int) -> UIView
}

class Dock: UIView {

    enum State {
        case show
        case hide
    }
    
    weak var delegate: DockDelegate?
    
    var customItemSize: [Int:CGSize] = [:]
    var itemsSize = CGSize(width: 50, height: 50)
    var isUserInteractionEnabledItems = false
    var blurEnabled = false
    var opacity: CGFloat = 1.0
    
    private(set) var layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    private(set) var container = UIView()
    private(set) var collection: UICollectionView = UICollectionView(frame: .zero,collectionViewLayout: UICollectionViewFlowLayout())


    init() {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        guard let delegate else {
            fatalError("Dock delegate has not been implemented")
        }
        
        return delegate.numberOfItemsCallback()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DockCell.identifier, for: indexPath) as! DockCell
        
        if let delegate {
            let item = delegate.cellItemCallback(indexPath.row)
            item.isUserInteractionEnabled = isUserInteractionEnabledItems
            cell.setupCell(item)
        }
            
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
}
