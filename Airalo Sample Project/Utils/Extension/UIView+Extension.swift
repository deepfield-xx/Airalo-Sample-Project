import UIKit

extension UIView {
    func applyShadow(offset: CGFloat = 10) {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: offset)
        layer.shadowRadius = 15
        layer.shadowOpacity = 0.15
        layer.masksToBounds = false
    }
}
