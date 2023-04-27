//
//  CollectionViewModel.swift
//  BackFront-BFNFT
//
//  Created by Alessandro Comparini on 03/04/23.
//

import UIKit

class CollectionViewModel {

    private var model = CollectionModel()
    
    var scrollDirection: UICollectionView.ScrollDirection {
        get { model.scrollDirection }
        set { model.scrollDirection = newValue }
    }
    
    var showsScroll: ShowsScroll? {
        get { model.showsScroll }
        set { model.showsScroll = newValue }
    }
    
    var padding: [CollectionPaddingModel] {
        get { model.padding }
    }
    
    var delaysContentTouches: Bool {
        get { model.delaysContentTouches }
        set { model.delaysContentTouches = newValue }
    }
    
    func getPadding() -> UIEdgeInsets {
        var resultEdges: [String:CGFloat] = [:]
        
        padding.forEach { pad in
            let edge: [String:CGFloat] = makeUpEdges(pad.edge, pad.size)
            resultEdges.merge(edge) { (_, new) in new }
        }
        
        return UIEdgeInsets(top: resultEdges["top"] ?? 0,
                            left: resultEdges["left"] ?? 0,
                            bottom: resultEdges["bottom"] ?? 0,
                            right: resultEdges["right"] ?? 0)
    }
    
    func padding(_ edge: Collection.Padding, _ size: CGFloat) {
        let paddingModel = CollectionPaddingModel(edge: edge, size: size)
        model.padding.append(paddingModel)
    }
    
    var registerCell: [AnyClass] {
        get { model.registerCell }
    }
    func registerCell(_ cell: AnyClass) {
        model.registerCell.append(cell)
    }
    
    
    private func makeUpEdges(_ padding: Collection.Padding, _ size: CGFloat) -> [String:CGFloat] {
        
        switch padding {
        case .bottom:
            return ["bottom": size]
        case .top:
            return ["top": size]
        case .left:
            return ["left": size]
        case .right:
            return ["right": size]
        case .horizontal:
            return ["left": size, "right": size]
        case .vertical:
            return ["top": size, "bottom": size]
        case .all:
            return ["left": size, "right": size,"top": size, "bottom": size]
        }
        
    }
    
}
