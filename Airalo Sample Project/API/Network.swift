import Foundation
import Alamofire

enum Network {
    
}

extension Network {
    var path: String {
        return ""
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var encoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    var parameters: Parameters? {
        return [:]
    }
    
    var headers: HTTPHeaders {
        switch self {
        default:
            let headers: HTTPHeaders = [
                "Content-Type": "application/json",
                "Accept": "application/vnd.myplace+json; version=1.0"
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
