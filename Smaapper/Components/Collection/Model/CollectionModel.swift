//
//  CollectionModel.swift
//  BackFront-BFNFT
//
//  Created by Alessandro Comparini on 03/04/23.
//

import UIKit

struct CollectionModel {
    
    var scrollDirection: UICollectionView.ScrollDirection = .vertical
    var showsScroll: ShowsScroll? = nil
    var padding: [CollectionPaddingModel] = []
    var registerCell: [AnyClass] = []
    var delaysContentTouches: Bool = false

}
