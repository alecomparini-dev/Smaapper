//
//  CollectionView.swift
//  BackFront-BFNFT
//
//  Created by Alessandro Comparini on 03/04/23.
//

import UIKit

class CollectionView: UICollectionView, UIGestureRecognizerDelegate {

    private let layout = UICollectionViewFlowLayout()

    func customScrollDirection(_ scrollDirection: UICollectionView.ScrollDirection) {
        layout.scrollDirection = scrollDirection
    }
    
    func customShowsScroll(_ showsScroll: ShowsScroll, _ flag: Bool) {
        switch showsScroll {
        case .horizontal:
            self.showsHorizontalScrollIndicator = flag
        case .vertical:
            self.showsVerticalScrollIndicator = flag
        case .both:
            self.showsVerticalScrollIndicator = flag
            self.showsHorizontalScrollIndicator = flag
        }
    }
    
    func customPadding(_ edges: UIEdgeInsets) {
        layout.sectionInset = edges
    }
    
    func customRegisterCell(_ cell: AnyClass) {
        register(cell.self, forCellWithReuseIdentifier: String(describing: cell.self))
    }
    
    func customDelaysContentTouches(_ flag: Bool) {
        delaysContentTouches = flag
    }
    
    func setLayout() {
        setCollectionViewLayout(layout, animated: true)
    }
    

    
    
    
//  MARK: - DELEGATE
    func delegate(_ delegate: UICollectionViewDelegate, _ dataSource: UICollectionViewDataSource) {
        self.delegate = delegate
        self.dataSource = dataSource
    }
    
    func scrollToItem(_ at: IndexPath, _ scrollPosition: UICollectionView.ScrollPosition) {
        scrollToItem(at: at, at: scrollPosition, animated: true)
    }
    
}

