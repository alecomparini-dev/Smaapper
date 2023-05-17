
import UIKit

protocol StartOfConstraintsFlowProtocol {
    var setTop: StartOfConstraintsPositionFlow<ConstraintsPositionY> { get }
    var setBottom: StartOfConstraintsPositionFlow<ConstraintsPositionY> { get }
    var setLeading: StartOfConstraintsPositionFlow<ConstraintsPositionX> { get }
    var setTrailing: StartOfConstraintsPositionFlow<ConstraintsPositionX> { get }
    var setWidth: StartOfConstraintsSizeFlowProtocol { get }
    var setHeight: StartOfConstraintsSizeFlowProtocol { get }
    var setHorizontalAlignmentX: StartOfConstraintsAlignmentFlowProtocol { get }
    var setVerticalAlignmentY: StartOfConstraintsAlignmentFlowProtocol { get }
}


protocol StartOfConstraintsPositionFlowProtocol {
    associatedtype T
    var setTop: EndOfConstraintsPositionFlowProtocol { get }
    var setBottom: EndOfConstraintsPositionFlowProtocol { get }
    var setLeading: EndOfConstraintsPositionFlowProtocol { get }
    var setTrailing: EndOfConstraintsPositionFlowProtocol { get }
    var setWidth: EndOfConstraintsPositionFlowProtocol { get }
    var setHeight: EndOfConstraintsPositionFlowProtocol { get }
    func equalTo(_ element: UIView, _ attribute: T, _ constant: CGFloat) -> StartOfConstraintsFlow
    func equalTo(_ element: UIView, _ attribute: T) -> StartOfConstraintsFlow
    func lessThanOrEqualTo(_ element: UIView, _ attribute: T, _ constant: CGFloat) -> StartOfConstraintsFlow
    func lessThanOrEqualTo(_ element: UIView, _ attribute: T) -> StartOfConstraintsFlow
    func greaterThanOrEqualTo(_ element: UIView, _ attribute: T, _ constant: CGFloat) -> StartOfConstraintsFlow
    func greaterThanOrEqualTo(_ element: UIView, _ attribute: T) -> StartOfConstraintsFlow
    
    var equalToSafeArea: StartOfConstraintsFlow { get }
    func equalToSafeArea(_ constant: CGFloat) -> StartOfConstraintsFlow
    var lessThanOrEqualToSafeArea: StartOfConstraintsFlow { get }
    func lessThanOrEqualToSafeArea(_ constant: CGFloat) -> StartOfConstraintsFlow
    var greaterThanOrEqualToSafeArea: StartOfConstraintsFlow { get }
    func greaterThanOrEqualToSafeArea(_ constant: CGFloat) -> StartOfConstraintsFlow
    
    var equalToSuperView: StartOfConstraintsFlow { get }
    func equalToSuperView(_ constant: CGFloat) -> StartOfConstraintsFlow
    var lessThanOrEqualToSuperView: StartOfConstraintsFlow { get }
    func lessThanOrEqualToSuperView(_ constant: CGFloat) -> StartOfConstraintsFlow
    var greaterThanOrEqualToSuperView: StartOfConstraintsFlow { get }
    func greaterThanOrEqualToSuperView(_ constant: CGFloat) -> StartOfConstraintsFlow
    
}

protocol StartOfConstraintsSizeFlowProtocol {
    var setTop: EndOfConstraintsSizeFlowProtocol { get }
    var setBottom: EndOfConstraintsSizeFlowProtocol { get }
    var setLeading: EndOfConstraintsSizeFlowProtocol { get }
    var setTrailing: EndOfConstraintsSizeFlowProtocol { get }
    var setWidth: StartOfConstraintsSizeFlowProtocol { get }
    var setHeight: StartOfConstraintsSizeFlowProtocol { get }
    func equalTo(_ element: UIView) -> StartOfConstraintsFlow
    func lessThanOrEqualTo(_ element: UIView) -> StartOfConstraintsFlow
    func greaterThanOrEqualTo(_ element: UIView) -> StartOfConstraintsFlow
    func equalToConstant(_ constant: CGFloat) -> StartOfConstraintsFlow
    func lessThanOrEqualToConstant(_ constant: CGFloat) -> StartOfConstraintsFlow
    func greaterThanOrEqualToConstant(_ constant: CGFloat) -> StartOfConstraintsFlow
    var equalToSafeArea: StartOfConstraintsFlow { get }
    var equalToSuperView: StartOfConstraintsFlow { get }
}

protocol StartOfConstraintsAlignmentFlowProtocol {
    var setHorizontalAlignmentX: EndOfConstraintsAlignmentFlowProtocol { get }
    var setVerticalAlignmentY: EndOfConstraintsAlignmentFlowProtocol { get }
    func equalTo(_ element: UIView, _ constant: CGFloat) -> StartOfConstraintsFlow
    func equalTo(_ element: UIView) -> StartOfConstraintsFlow
    var equalToSafeArea: StartOfConstraintsFlow { get }
    func equalToSafeArea(_ constant: CGFloat) -> StartOfConstraintsFlow
    var equalToSuperView: StartOfConstraintsFlow { get }
    func equalToSuperView(_ constant: CGFloat) -> StartOfConstraintsFlow
}

protocol EndOfConstraintsAlignmentFlowProtocol {
    func equalTo(_ element: UIView) -> StartOfConstraintsFlow
    var equalToSafeArea: StartOfConstraintsFlow { get }
    var equalToSuperView: StartOfConstraintsFlow { get }
}

protocol EndOfConstraintsPositionFlowProtocol {
    var setTop: EndOfConstraintsPositionFlowProtocol{ get }
    var setBottom: EndOfConstraintsPositionFlowProtocol{ get }
    var setLeading: EndOfConstraintsPositionFlowProtocol{ get }
    var setTrailing: EndOfConstraintsPositionFlowProtocol{ get }
    var setWidth: EndOfConstraintsSizeFlowProtocol{ get }
    var setHeight: EndOfConstraintsSizeFlowProtocol{ get }
    func equalTo(_ element: UIView, _ constant: CGFloat) -> StartOfConstraintsFlow
    func equalTo(_ element: UIView) -> StartOfConstraintsFlow
    var equalToSafeArea: StartOfConstraintsFlow { get }
    func equalToSafeArea(_ constant: CGFloat) -> StartOfConstraintsFlow
    var equalToSuperView: StartOfConstraintsFlow { get }
    func equalToSuperView(_ constant: CGFloat) -> StartOfConstraintsFlow
}


protocol EndOfConstraintsSizeFlowProtocol  {
    var setTop: EndOfConstraintsSizeFlowProtocol { get }
    var setBottom: EndOfConstraintsSizeFlowProtocol { get }
    var setLeading: EndOfConstraintsSizeFlowProtocol { get }
    var setTrailing: EndOfConstraintsSizeFlowProtocol { get }
    var setWidth:  EndOfConstraintsSizeFlowProtocol { get }
    var setHeight:  EndOfConstraintsSizeFlowProtocol { get }
    func equalTo(_ element: UIView) -> StartOfConstraintsFlow
    var equalToSafeArea: StartOfConstraintsFlow { get }
    var equalToSuperView: StartOfConstraintsFlow { get }
}


