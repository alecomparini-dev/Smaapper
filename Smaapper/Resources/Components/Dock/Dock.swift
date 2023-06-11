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
    
    func shouldSelectItemAt(_ indexItem: Int?)
    func didSelectItemAt(_ indexItem: Int?)
    func didDeselectItemAt(_ indexItem: Int?)
    
    func removeItem(_ indexItem: Int)
    func insertItem(_ indexItem: Int)
}

class Dock: UIView {
    typealias closureGetCellItemAlias = (_ cellItem: UIView) -> Void
    weak var delegate: DockDelegate?
    
    private var closureGetCellItem: closureGetCellItemAlias?
    private var indexGetCellItem: Int?
    
    private(set) var id: UUID = UUID()
    
    let hierarchy: CGFloat = 1100
    let marginContainer: CGFloat = 8
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

    func getIndexSelected() -> Int? {
        if let selectedIndexPaths = collection.indexPathsForSelectedItems?.first {
            let selectedIndex = selectedIndexPaths.item
            return selectedIndex
        }
        return nil
    }

    func setClosureGetCellItem(_ indexItem: Int, closure: @escaping closureGetCellItemAlias) {
        self.indexGetCellItem = indexItem
        self.closureGetCellItem = closure
    }

    
    
//  MARK: - PRIVATE Area
    
    private func invokeGetCellItem(_ cell: UIView) {
        self.closureGetCellItem?(cell)
        self.indexGetCellItem = nil
        self.closureGetCellItem = nil
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
        
        if self.indexGetCellItem == indexPath.row  {
            invokeGetCellItem(cell)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        if getIndexSelected() == indexPath.row {return false}
        print("vaiiiiii SELECIONrrrrr ")
        delegate?.shouldSelectItemAt(indexPath.row)
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("SELECIONOUUU ")
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        delegate?.didSelectItemAt(indexPath.row)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        print("DESELECIONOUUU !!!!!!!!!!!!!")
        delegate?.didDeselectItemAt(indexPath.row)
    }
    
    
    
}


extension DockDelegate {
    func shouldSelectItemAt(_ indexItem: Int?) {}
    func didSelectItemAt(_ indexItem: Int?) {}
    func didDeselectItemAt(_ indexItem: Int?) {}
    func removeItem(_ indexItem: Int) {}
    func insertItem(_ indexItem: Int) {}
}
