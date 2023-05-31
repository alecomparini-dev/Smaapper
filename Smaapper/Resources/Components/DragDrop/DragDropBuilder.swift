//
//  DragDropBuilder.swift
//  Smaapper
//
//  Created by Alessandro Comparini on 30/05/23.
//

import UIKit


class DragDropBuilder  {
    
    
    private var originalPosition: CGPoint = .zero
    private(set) var dragDrop: DragDrop?
    private let component: UIView
    
//    init(_ component: UIView) {
//        self.component = component
//        self.initialization()
//    }
    
    
    private func initialization() {
        enableUserInteractionComponent()
        createTapGesture()
//        addTapOnComponent()
        
    }
    
        private var panGestureRecognizer: UIPanGestureRecognizer!
        
        init(_ component: UIView) {
            self.component = component
            
            panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
            component.isUserInteractionEnabled = true
            component.addGestureRecognizer(panGestureRecognizer)
        }
        
        @objc private func handlePan(_ gestureRecognizer: UIPanGestureRecognizer) {
            let translation = gestureRecognizer.translation(in: component.superview)
            
            switch gestureRecognizer.state {
            case .began, .changed:
                component.center = CGPoint(x: component.center.x + translation.x, y: component.center.y + translation.y)
                gestureRecognizer.setTranslation(.zero, in: component.superview)
                
            default:
                break
            }
        }
    
    private func enableUserInteractionComponent() {
        self.component.isUserInteractionEnabled = true
    }
    
    
    private func createTapGesture() {
        let dragDrop = DragDrop(target: self, action: #selector(pandGesture(_:)))
        self.component.addGestureRecognizer(dragDrop)
    }
    
    @objc func pandGesture(_ gesture: DragDrop) {
        let translation = gesture.translation(in: component)
        
        switch gesture.state {
        case .began:
            originalPosition = component.center
            
        case .changed:
            let newPosition = CGPoint(x: originalPosition.x + translation.x, y: originalPosition.y + translation.y)
            component.center = newPosition
            
        case .ended:
            break
            
        case .cancelled:
            break
            
        default:
            break
        }
    }


    //  MARK: - Objc Function Area


    /*
     
     ATUALIZAR PARA UMA FUNCAO OBJC QUE TEM O SWITCH DOS STATES
     E CHAMA OS DELEGATES
     
     IGUAL EXEMPLO COLOCADO NA HOME VIEW
     
     
     @objc func handlePan(_ gesture: UIPanGestureRecognizer) {
             let translation = gesture.translation(in: view)
             
             switch gesture.state {
             case .began:
                 // Salve a posição original da label
                 originalPosition = draggableLabel.center
                 
             case .changed:
                 // Atualize a posição da label com base no gesto de arrastar
                 let newPosition = CGPoint(x: originalPosition.x + translation.x, y: originalPosition.y + translation.y)
                 draggableLabel.center = newPosition
                 
             case .ended:
                 // Faça o que for necessário após o término do gesto de arrastar
                 
             default:
                 break
             }
         }
     
     
     */
    
}
