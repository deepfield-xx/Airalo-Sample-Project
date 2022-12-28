import Foundation
import Combine

class LocalESIMViewModel {
    let serviceContainer: ServiceContainable
    
    var cancelables = Set<AnyCancellable>()
    var localESIMs = [LocalESIM]()
    
    @Published var isLoading = false
    @Published var error: Error?
    
    init(serviceContainer: ServiceContainable) {
        self.serviceContainer = serviceContainer
    }
    
    func getLocalESIMs() {
        isLoading = true
        error = nil
        
        serviceContainer.networkService.request(.localESIM)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.isLoading = false
                    self.error = error
                }
            } receiveValue: { (esims: [LocalESIM]) in
                self.localESIMs.append(contentsOf: esims)
                self.isLoading = false
            }
            .store(in: &cancelables)
    }
}
