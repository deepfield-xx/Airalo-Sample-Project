import Foundation

protocol ServiceContainable {
    var networkService: NetworkServiceable { get }
}

struct ServiceContainer: ServiceContainable {
    let networkService: NetworkServiceable
}
