//
//  Collection.swift
//  BackFront-BFNFT
//
//  Created by Alessandro Comparini on 03/04/23.
//

import UIKit

class Collection: CollectionBuilder {

    enum Padding {
        case bottom
        case top
        case left
        case right
        case horizontal
        case vertical
        case all
    }
    
//  MARK: VIEW
    private let collection: CollectionView
    var view: CollectionView { collection }
    
    private let collectionVM = CollectionViewModel()
    
    init () {
        self.collection = CollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout.init())
        super.init(collection, collectionVM)
    }
    
    
//  MARK: - DELEGATE
    func delegate(_ delegate: UIViewController) {
        let delegate: UICollectionViewDelegate = delegate as! UICollectionViewDelegate
        let dataSource: UICollectionViewDataSource = delegate as! UICollectionViewDataSource
        collection.delegate(delegate, dataSource)
    }
    
    
//  MARK: - scrollToItem
    func scrollToItem(_ at: IndexPath) {
        if collectionVM.showsScroll == .vertical {
            collection.scrollToItem(at, .centeredVertically)
            return
        }
        collection.scrollToItem(at, .centeredHorizontally)
    }

    
}
