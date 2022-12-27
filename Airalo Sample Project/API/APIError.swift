import Foundation

struct APIErrorMessage: Codable {
    let message: String
}

enum APIErrorType: String, Codable {
    case validationError = "ValidationError"
    case unknown
}

struct APIErrorBody: Codable {
    let errors: [APIErrorMessage]?
    let error_type: APIErrorType?
    
    var message: String? {
        return errors?.map { $0.message }.joined(separator: "\n")
    }
}

enum APIError: Error {
    case unknown
    case invalidToken
    case noConnection
    case error(APIErrorBody)
    
    var title: String? {
        switch self {
        case .unknown:
            return "?"
        case .invalidToken:
            return ""
        case .noConnection:
            return ""
        case .error:
            return "Something went wrong"
        }
    }
    
    var message: String? {
        switch self {
        case .unknown:
            return "Something went wrong"
        case .invalidToken:
            return "Invalid token"
        case .noConnection:
            return "No connection"
        case .error(let body):
            return body.message
        }
    }
}
