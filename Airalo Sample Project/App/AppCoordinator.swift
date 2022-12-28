import UIKit

final class AppCoordinator: Coordinator {
    private weak var window: UIWindow?
    
    init(window: UIWindow?, serviceContainer: ServiceContainable) {
        self.window = window
        let navigationController = NavigationController()
        
        super.init(delegate: nil, navigationController: navigationController)
        self.serviceContainer = serviceContainer
    }
    
    func start() {
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        let viewModel = MainViewModel(serviceContainer: serviceContainer)
        let mainVc = MainViewController(viewModel: viewModel)
        mainVc.delegate = self
        navigationController?.setViewControllers([mainVc], animated: false)
    }
    
    private func presentCountryPackages(_ esim: LocalESIM) {
        let viewModel = CountryPackageViewModel(esim: esim, serviceContainer: serviceContainer)
        let countryPackageViewController = CountryPackageViewController(viewModel: viewModel)
        navigationController?.pushViewController(countryPackageViewController, animated: true)
    }
}

extension AppCoordinator: MainViewControllerDelegate {}

extension AppCoordinator: LocalESIMViewControllerDelegate {
    func didSelect(_ esim: LocalESIM) {
        presentCountryPackages(esim)
    }
}
