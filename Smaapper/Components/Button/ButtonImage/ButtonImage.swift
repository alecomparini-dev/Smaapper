//
//  ButtonImage.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 28/04/23.
//

import UIKit


class ButtonImage: Button {
    
    enum Position {
        case leading
        case trailing
        
        
    }
    
    
//  MARK: - Initializers
    
    init(_ image: UIImageView, _ state: UIControl.State, _ size: CGFloat? = nil) {
        super.init()
        setImage(image, state, size)
    }
    
    convenience init(_ image: UIImageView, _ state: UIControl.State) {
        self.init(image, state, nil)
    }
    
    convenience init(_ image: UIImageView) {
        self.init(image, .normal, nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//  MARK: - Properties
    
    
    
//  MARK: - Private Function Area
    
    private func setImage(_ image: UIImageView, _ state: UIControl.State, _ size: CGFloat? = nil ) {
        if let size = size {
            setImage(image.image!.withConfiguration(UIImage.SymbolConfiguration(pointSize: size)), for: state)
            return
        }
        setImage(image.image!, for: state)
    }
    
    
//    private func getImagePosition() -> UISemanticContentAttribute {
//        switch buttonVM.imageAlignment.imagePosition {
//            case .leading:
//                return .forceLeftToRight
//            case .trailing:
//                return .forceRightToLeft
//        }
//    }
    
}
