//
//  View.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 27/04/23.
//

import UIKit


class View: UIView {
    
    init() {
        super.init(frame: .zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        Resize.resize(self)
//        print("remover aqui layoutsubviews" , self)
    }

    
}
