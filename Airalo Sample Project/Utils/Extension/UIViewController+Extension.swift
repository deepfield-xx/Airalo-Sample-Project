import UIKit
import Stevia

extension UIViewController {
    func add(child: UIViewController, to: UIView? = nil, animated: Bool = false) {
        addChild(child)
        
        let parentView = to ?? view
        parentView?.subviews(child.view)
        child.view.fillContainer()
        child.didMove(toParent: self)
        if animated {
            child.view.alpha = 0
            UIView.animate(withDuration: 0.2) {
                child.view.alpha = 1
            }
        }
    }
}
