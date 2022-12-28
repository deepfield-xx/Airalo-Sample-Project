import UIKit
import Stevia

protocol TabBarItemDelegate: AnyObject {
    func didSelect(item: TabBarItem)
}

class TabBarItem: UIView {
    private let name: String
    private let label = UILabel()
    
    weak var delegate: TabBarItemDelegate?
    
    init(name: String) {
        self.name = name
        super.init(frame: .zero)
        
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp() {
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTap)))
        
        layer.cornerRadius = 7
        
        label.contentMode = .top
        label.textColor = UIColor(hex: 0x4A4A4A)
        label.font = UIFont.ibmPlexSansMedium(13)
        label.attributedText = NSMutableAttributedString(string: name).lineHeight(15)
        label.textAlignment = .center
        
        subviews {
            label
        }
        
        label.centerVertically().centerHorizontally()
    }
    
    @objc private func didTap() {
        delegate?.didSelect(item: self)
    }
    
    var isSelected = false {
        didSet {
            label.textColor = isSelected ? UIColor(hex: 0x4A4A4A) : UIColor(hex: 0x8A8A8A)
            backgroundColor = isSelected ? UIColor(hex: 0xEEEEEE) : .white
        }
    }
}
