import Foundation
import UIKit

public typealias VoidHandler = () -> Void

protocol CoordinatorDelegate: AnyObject {
    func coordinatorDidFinish(_ coordinator: Coordinator)
}

class Coordinator: NSObject, CoordinatorDelegate {
    weak var delegate: CoordinatorDelegate?
    var serviceContainer: ServiceContainable!
    var navigationController: UINavigationController?
    
    private var childCoordinators: [Coordinator]
    
    var topMostCoordinator: Coordinator {
        var topMostCoordinator = self
        while let nextCoordinator = topMostCoordinator.childCoordinators.first {
            topMostCoordinator = nextCoordinator
        }
        return topMostCoordinator
    }
    
    init(
        delegate: CoordinatorDelegate?,
        navigationController: UINavigationController?
    ) {
        self.delegate = delegate
        self.childCoordinators = []
        self.navigationController = navigationController
    }
    
    deinit {
        print("\(self) has been deallocated")
    }
    
    func back() {
        navigationController?.popViewController(animated: true)
    }
    
    func close() {
        close(animated: true)
    }
    
    func close(
        animated: Bool = false,
        _ completion: VoidHandler? = nil
    ) {
        navigationController?.presentedViewController?.dismiss(
            animated: animated,
            completion: completion
        )
        delegate?.coordinatorDidFinish(self)
    }
    
    func addChild(coordinator childCoordinator: Coordinator) {
        childCoordinators.append(childCoordinator)
        childCoordinator.serviceContainer = serviceContainer
    }
    
    func getChildren<T: Coordinator>() -> [T] {
        return childCoordinators.compactMap() { $0 as? T }
    }
    
    private func removeChild(coordinator: Coordinator) {
        childCoordinators = childCoordinators.filter { $0 !== coordinator }
    }
    
    // MARK: - CoordinatorDelegate
    func coordinatorDidFinish(_ coordinator: Coordinator) {
        removeChild(coordinator: coordinator)
    }
}
