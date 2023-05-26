//
//  ImageViewActions.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 25/05/23.
//

import UIKit


class ImageViewActions: BaseActions {
    
    typealias touchImageViewClosureAlias = (_ imageView: UIImageView ) -> Void
    
    private let imageViewBuilder: ImageViewBuilder
    
    init(_ imageViewBuilder: ImageViewBuilder) {
        self.imageViewBuilder = imageViewBuilder
        super.init(self.imageViewBuilder)
    }

}
