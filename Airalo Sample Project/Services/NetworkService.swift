import Foundation
import Alamofire
import Combine

protocol NetworkServiceable {
    func request<T: Codable>(_ endpoint: Network) -> AnyPublisher<T, APIError>
}

final class NetworkService: NetworkServiceable {
    private let decoder = JSONDecoder()
    
    init() {
//        decoder.dateDecodingStrategy = .formatted(MessagingDataFormatter())
    }
    
    func request<T: Codable>(_ endpoint: Network) -> AnyPublisher<T, APIError> {
        return AF.request(endpoint)
            .validate()
            .responseDecodable(of: T.self, decoder: decoder) { [unowned self] response in
                self.printDetails(response)
            }
            .publishDecodable(type: T.self, decoder: decoder)
            .flatMap { value -> AnyPublisher<T, APIError> in
                if let type = value.value {
                    return Just(type)
                        .setFailureType(to: APIError.self)
                        .eraseToAnyPublisher()
                } else {
                    switch value.result {
                    case .failure:
                        break
                    default:
                        break
                    }
                    
                    return Fail(error: APIError.unknown).eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }
    
    private func printDetails(_ object: Any) {
    #if DEBUG || LIVE
        debugPrint(object)
    #endif
    }
}
