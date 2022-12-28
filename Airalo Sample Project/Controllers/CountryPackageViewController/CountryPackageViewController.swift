
import UIKit
import Stevia
import Combine

class CountryPackageViewController: ViewController {
    private let titleLabel = UILabel()
    private let shadowView = UIView()
    private let tableView = UITableView(frame: .zero, style: .grouped)
    private let backButton = UIButton()
    
    private let viewModel: CountryPackageViewModel
    
    var cancelables = Set<AnyCancellable>()
    
    init(viewModel: CountryPackageViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setUp() {
        super.setUp()
        
        shadowView.backgroundColor = .white
        shadowView.applyShadow()
        
        titleLabel.font = UIFont.ibmPlexSansSemiBold(27)
        titleLabel.attributedText = NSMutableAttributedString(string: viewModel.title)
            .kern(-0.5).lineHeight(32)
        titleLabel.textColor = UIColor(hex: 0x4A4A4A)
        
        tableView.register(CountryPackageViewCell.self, forCellReuseIdentifier: CountryPackageViewCell.typeName)
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.showsVerticalScrollIndicator = false
        tableView.alwaysBounceVertical = false
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        
        backButton.setImage(UIImage(named: "BackArrow"), for: .normal)
        backButton.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)
        
        view.subviews {
            tableView
            shadowView
            titleLabel
            backButton
        }
        
        shadowView.top(0).left(0).right(0).height(140)
        titleLabel.left(20).right(20)
        titleLabel.Bottom == shadowView.Bottom - 8
        tableView.left(0).right(0).bottom(0)
        tableView.Top == shadowView.Bottom
        
        backButton.left(7)
        backButton.Bottom == titleLabel.Top - 18
        
        viewModel.$isLoading
            .sink { isLoading in
                if isLoading {
                    self.showLoader()
                } else {
                    self.hideLoader()
                    self.tableView.reloadData()
                }
            }
            .store(in: &cancelables)
        
        viewModel.getCountryPackages()
    }
    
    @objc private func didTapBack() {
        navigationController?.popViewController(animated: true)
    }
}

extension CountryPackageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.packages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let package = viewModel.packages[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CountryPackageViewCell.typeName, for: indexPath) as? CountryPackageViewCell else {
            return UITableViewCell()
        }
        
        cell.prepare(with: package)
        return cell
    }
}
