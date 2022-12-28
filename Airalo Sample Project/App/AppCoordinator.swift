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
        navigationController?.setViewControllers([mainVc], animated: false)
    }
}
