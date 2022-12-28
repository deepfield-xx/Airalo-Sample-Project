import UIKit
import Stevia

class MainViewController: UIViewController {
    private let titleLabel = UILabel()
    private let searchField = UITextField()
    private let navBar = TabBar()
    private let shadowView = UIView()
    
    private let viewModel: MainViewModel
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUp()
        setUpLayout()
        
        view.backgroundColor = .white
    }
    
    private func setUp() {
        titleLabel.font = UIFont.ibmPlexSansSemiBold(27)
        titleLabel.attributedText = NSMutableAttributedString(string: "Hello").kern(-0.5).lineHeight(32)
        titleLabel.textColor = UIColor(hex: 0x4A4A4A)
        
        searchField.leftViewMode = .always
        let imageView = UIImageView(frame: CGRect(x: 3, y: 7, width: 22, height: 22))
        let image = UIImage(named: "Search")
        imageView.image = image
        let imageContainer = UIView(frame: CGRect(x: 0, y: 0, width: 28, height: 36))
        imageContainer.addSubview(imageView)
        
        searchField.leftView = imageContainer
        searchField.backgroundColor = UIColor(hex: 0xEEEEEE)
        searchField.layer.cornerRadius = 7
        searchField.font = UIFont.ibmPlexSans(13)
        searchField.attributedPlaceholder = NSMutableAttributedString(string: "Search data packs for +190 countries and reg...").color(UIColor(hex: 0x8A8A8A))
        
        navBar.addItems(["Local eSIMs", "Regional eSIMs", "Global eSIM"])
        
        shadowView.backgroundColor = .white
        shadowView.applyShadow()
        
        view.subviews {
            shadowView
            titleLabel
            searchField
            navBar
        }
    }

    private func setUpLayout() {
        view.layout {
            100
            |-20-titleLabel-20-|
            9
            |-20-searchField-20-| ~ 36
            23
            |-20-navBar-20-| ~ 28
        }
        
        shadowView.top(0).left(0).right(0)
        shadowView.Bottom == navBar.Bottom + 8
    }
}
