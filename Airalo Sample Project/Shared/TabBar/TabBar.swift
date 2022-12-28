import UIKit
import Stevia

class TabBar: UIView {
    private let stackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp() {
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.alignment = .fill
        stackView.spacing = 12
        
        subviews {
            stackView
        }
        
        stackView.fillContainer()
    }
    
    func addItems(_ names: [String]) {
        for name in names {
            let item = TabBarItem(name: name)
            item.delegate = self
            stackView.addArrangedSubview(item)
            
            item.isSelected = name == names.first
        }
    }
}

extension TabBar: TabBarItemDelegate {
    func didSelect(item: TabBarItem) {
        if let items = stackView.arrangedSubviews as? [TabBarItem] {
            items.forEach {
                $0.isSelected = $0 == item
            }
        }
    }
}
