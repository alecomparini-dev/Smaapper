//
//  ImageView.swift
//  BackFront-ChatALPC
//
//  Created by Alessandro Comparini on 22/04/23.
//

import UIKit

class ImageView: UIImageView {
    
    typealias tapActionClosureAlias = (_ imageView: UIImageView) -> Void
    private var tapAction: tapActionClosureAlias?
    
    
    //  MARK: - Initializers
    
    init() {
        super.init(frame: .zero)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

