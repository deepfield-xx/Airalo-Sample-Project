//
//  LocalESIMViewController.swift
//  Airalo Sample Project
//
//  Created by MyPlace on 28/12/2022.
//

import UIKit
import Combine

class LocalESIMViewController: ViewController {
    private let viewModel: LocalESIMViewModel
    private let tableView = UITableView(frame: .zero, style: .grouped)
    
    var cancelables = Set<AnyCancellable>()
    
    init(viewModel: LocalESIMViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setUp() {
        tableView.register(LocalESIMViewCell.self, forCellReuseIdentifier: LocalESIMViewCell.typeName)
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.showsVerticalScrollIndicator = false
        tableView.alwaysBounceVertical = false
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: 24, left: 0, bottom: 0, right: 0)
        tableView.delegate = self
        tableView.dataSource = self
        
        view.subviews(tableView)
        tableView.fillContainer()
        
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
        
        viewModel.getLocalESIMs()
    }
}

extension LocalESIMViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.localESIMs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let esim = viewModel.localESIMs[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LocalESIMViewCell.typeName, for: indexPath) as? LocalESIMViewCell else {
            return UITableViewCell()
        }
        
        cell.prepare(with: esim)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 47
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 47))
        
        let label = UILabel(frame: CGRect(x: 20, y: 0, width: 100, height: 50))
        label.font = UIFont.ibmPlexSansSemiBold(19)
        label.textColor = UIColor(hex: 0x4A4A4A)
        label.attributedText = NSMutableAttributedString(string: "Popular Countries").lineHeight(22).kern(-0.2)
        label.sizeToFit()
        
        view.addSubview(label)
        
        return view
    }
}
