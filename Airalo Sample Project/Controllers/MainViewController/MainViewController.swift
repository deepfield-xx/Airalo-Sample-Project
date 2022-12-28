import UIKit
import Stevia
import Combine

protocol MainViewControllerDelegate: LocalESIMViewControllerDelegate {
    
}

class MainViewController: UIViewController {
    private let titleLabel = UILabel()
    private let searchField = UITextField()
    private let tabBar = TabBar()
    private let shadowView = UIView()
    private let containerView = UIView()
    
    private let viewModel: MainViewModel
    
    weak var delegate: MainViewControllerDelegate?
    private var localESIMController: LocalESIMViewController?
    private var cancelables = Set<AnyCancellable>()
    
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
        showLocalESIMS()
        
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
        
        tabBar.addItems(["Local eSIMs", "Regional eSIMs", "Global eSIM"])
        
        shadowView.backgroundColor = .white
        shadowView.applyShadow()
        
        view.subviews {
            containerView
            shadowView
            titleLabel
            searchField
            tabBar
        }
        
        tabBar.$selectedIndex
            .sink { index in
                if index == 0 {
                    self.showLocalESIMS()
                } else if index == 1 {
                    self.showRegionalESIM()
                } else if index == 2 {
                    self.showGlobalESIM()
                }
            }
            .store(in: &cancelables)
    }

    private func setUpLayout() {
        view.layout {
            100
            |-20-titleLabel-20-|
            9
            |-20-searchField-20-| ~ 36
            23
            |-20-tabBar-20-| ~ 44
        }
        
        shadowView.top(0).left(0).right(0)
        shadowView.Bottom == tabBar.Bottom
        containerView.Top == shadowView.Bottom
        containerView.left(0).right(0).bottom(0)
    }
    
    private func showLocalESIMS() {
        if localESIMController == nil {
            let localViewModel = LocalESIMViewModel(serviceContainer: viewModel.serviceContainer)
            localESIMController = LocalESIMViewController(viewModel: localViewModel)
            localESIMController?.delegate = delegate
        }
        
        containerView.subviews.forEach { $0.removeFromSuperview() }
        add(child: localESIMController!, to: containerView, animated: true)
    }
    
    private func showRegionalESIM() {
        // ....
        containerView.subviews.forEach { $0.removeFromSuperview() }
    }
    
    private func showGlobalESIM() {
        // ...
        containerView.subviews.forEach { $0.removeFromSuperview() }
    }
}
