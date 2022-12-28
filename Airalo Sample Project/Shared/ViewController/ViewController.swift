//
//  ViewController.swift
//  Airalo Sample Project
//
//  Created by MyPlace on 28/12/2022.
//

import UIKit
import Stevia

class ViewController: UIViewController {
    private var loader = UIActivityIndicatorView(style: .medium)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUp()
    }

    func setUp() {
        loader.color = .gray
        loader.hidesWhenStopped = true
    }
    
    func showLoader() {
        view.subviews(loader)
        loader.centerVertically().centerHorizontally()
        
        loader.startAnimating()
    }
    
    func hideLoader() {
        loader.stopAnimating()
    }
}
