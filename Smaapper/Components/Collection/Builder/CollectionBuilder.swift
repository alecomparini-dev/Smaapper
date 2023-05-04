//
//  CollectionBuilder.swift
//  BackFront-ChatALPC
//
//  Created by Alessandro Comparini on 05/04/23.
//

import UIKit

class CollectionBuilder {
    
    
    private let collection: CollectionView
    private let collectionVM: CollectionViewModel
    
    
    init(_ collection: CollectionView, _ collectionVM: CollectionViewModel) {
        self.collection = collection
        self.collectionVM = collectionVM
    }
    
    
    func setScrollDirection(_ scrollDirection: UICollectionView.ScrollDirection) -> Self {
        collectionVM.scrollDirection = scrollDirection
        return self
    }
    
    func setShowsScroll(_ showsScroll: ShowsScroll) -> Self {
        collectionVM.showsScroll = showsScroll
        return self
    }
    
    func setPadding(_ edge: Collection.Padding, _ size: CGFloat) -> Self {
        collectionVM.padding(edge, size)
        return self
    }
    
    func setRegisterCell(_ cell: AnyClass) -> Self {
        collectionVM.registerCell(cell)
        return self
    }
    
    func setDelaysContentTouches(_ flag: Bool) -> Self {
        collectionVM.delaysContentTouches = flag
        return self
    }
    
//  MARK: - BUILD COMPONENT
    func build () -> Self {
        buildScrollDirection()
        buildShowsScroll()
        buildPadding()
        buildRegisterCell()
        buildLayout()
        buildDelaysContentTouches()
        return self
    }
    
    private func buildScrollDirection() {
        collection.customScrollDirection(collectionVM.scrollDirection)
    }
    
    private func buildShowsScroll() {
        guard let showsScroll = collectionVM.showsScroll else {
            collection.customShowsScroll(.both, false)
            return
        }
        collection.customShowsScroll(showsScroll, true)
    }
    
    private func buildPadding() {
        if collectionVM.padding.count == 0 {return}
        collection.customPadding(collectionVM.getPadding())
    }
    
    private func buildRegisterCell() {
        if collectionVM.registerCell.count == 0 {
            debugPrint("Collection without registered cell!")
            return
        }
        collectionVM.registerCell.forEach { cell in
            collection.customRegisterCell(cell)
        }
    }
    
    private func buildLayout() {
        collection.setLayout()
    }
    
    private func buildDelaysContentTouches() {
        collection.customDelaysContentTouches(collectionVM.delaysContentTouches)
    }


}
