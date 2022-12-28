import Foundation
import Alamofire

enum Network {
    case localESIM
}

extension Network {
    var path: String {
        switch self {
        case .localESIM:
            return "countries"
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var encoding: ParameterEncoding {
        return  URLEncoding.queryString
    }
    
    var parameters: Parameters? {
        switch self {
        case .localESIM:
            return ["type": "popular"]
        }
    }
    
    var headers: HTTPHeaders {
        switch self {
        default:
            let headers: HTTPHeaders = [
                "Content-Type": "application/json"
            ]

            return headers
        }
    }
}

extension Network: URLRequestConvertible {
    func asURLRequest() throws -> URLRequest {
        var urlRequest = try URLRequest(url: asURL())
        urlRequest.httpMethod = method.rawValue
        
        headers.forEach { header in
            urlRequest.setValue(header.value, forHTTPHeaderField: header.name)
        }
        
        return try encoding.encode(urlRequest, with: parameters)
    }
}

extension Network: URLConvertible {
    func asURL() throws -> URL {
        return URL(string: "https://www.airalo.com/api/v2/")!
            .appendingPathComponent(path)
    }
}
