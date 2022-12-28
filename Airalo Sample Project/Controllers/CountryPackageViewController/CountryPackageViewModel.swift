import Foundation
import Combine

class CountryPackageViewModel {
    let esim: LocalESIM
    let serviceContainer: ServiceContainable
    
    var cancelables = Set<AnyCancellable>()
    var packages = [CountryPackage]()
    
    @Published var isLoading = false
    @Published var error: Error?
    
    init(esim: LocalESIM, serviceContainer: ServiceContainable) {
        self.esim = esim
        self.serviceContainer = serviceContainer
    }
    
    var title: String {
        return esim.title
    }
    
    func getCountryPackages() {
        isLoading = true
        error = nil
        
        serviceContainer.networkService.request(.countryPackage(esim.slug))
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.isLoading = false
                    self.error = error
                }
            } receiveValue: { (packages: CountryPackages) in
                self.packages = packages.packages
                self.isLoading = false
            }
            .store(in: &cancelables)
    }
}
